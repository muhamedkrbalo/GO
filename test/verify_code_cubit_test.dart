import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_hr_erb/core/error/failures.dart';
import 'package:flutter_hr_erb/features/auth/data/model/verification_method.dart';
import 'package:flutter_hr_erb/features/auth/data/model/verify_account_args.dart';
import 'package:flutter_hr_erb/features/auth/data/model/verify_code_args.dart';
import 'package:flutter_hr_erb/features/auth/data/repository/auth_repository.dart';
import 'package:flutter_hr_erb/features/auth/presentation/controller/verify_code_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeAuthRepository implements AuthRepository {
  String validCode = '123456';
  int sendCalls = 0;

  @override
  Future<Either<Failure, Unit>> sendVerificationCode(VerifyCodeArgs args) async {
    sendCalls++;
    return const Right(unit);
  }

  @override
  Future<Either<Failure, Unit>> verifyCode(VerifyCodeArgs args, String code) async =>
      code == validCode ? const Right(unit) : Left(ServerFailure('invalid'));
}

void main() {
  const args = VerifyCodeArgs(
    method: VerificationMethod.sms,
    account: VerifyAccountArgs(phoneCode: '20', phone: '1012345678', email: 'nada@gmail.com'),
  );
  late _FakeAuthRepository repository;
  late VerifyCodeCubit cubit;

  setUp(() {
    repository = _FakeAuthRepository();
    cubit = VerifyCodeCubit(repository, args);
  });

  tearDown(() => cubit.close());

  test('masks the destination', () {
    expect(args.maskedDestination, '+20 ••• ••• 5678');
    expect(args.destination, '+201012345678');
  });

  test('cannot verify until the code is complete', () async {
    cubit.codeChanged('123');
    expect(cubit.state.canVerify, isFalse);
    cubit.codeChanged('123456');
    expect(cubit.state.canVerify, isTrue);
  });

  test('wrong code clears the input and spends an attempt', () async {
    cubit.codeChanged('000000');
    await cubit.verify();
    expect(cubit.state.status, VerifyCodeStatus.invalid);
    expect(cubit.state.code, isEmpty);
    expect(cubit.state.attemptsRemaining, VerifyCodeCubit.maxAttempts - 1);
    expect(cubit.state.hasError, isTrue);
  });

  test('typing after an error clears it', () async {
    cubit.codeChanged('000000');
    await cubit.verify();
    cubit.codeChanged('1');
    expect(cubit.state.hasError, isFalse);
  });

  testWidgets('locks after the last attempt and resend unlocks after the cooldown', (
    tester,
  ) async {
    final cubit = VerifyCodeCubit(repository, args);
    await cubit.sendCode();
    for (var i = 0; i < VerifyCodeCubit.maxAttempts; i++) {
      cubit.codeChanged('000000');
      await cubit.verify();
    }
    expect(cubit.state.isLocked, isTrue);
    cubit.codeChanged('123456');
    expect(cubit.state.canVerify, isFalse);

    await cubit.resendCode();
    expect(repository.sendCalls, 1);

    await tester.pump(const Duration(seconds: VerifyCodeCubit.resendCooldown));
    expect(cubit.state.canResend, isTrue);

    await cubit.resendCode();
    expect(repository.sendCalls, 2);
    expect(cubit.state.attemptsRemaining, VerifyCodeCubit.maxAttempts);
    expect(cubit.state.isLocked, isFalse);
    unawaited(cubit.close());
  });

  test('correct code verifies', () async {
    cubit.codeChanged('123456');
    await cubit.verify();
    expect(cubit.state.status, VerifyCodeStatus.verified);
    expect(cubit.state.canVerify, isFalse);
  });

  test('sending a code starts the resend cooldown', () async {
    await cubit.sendCode();
    expect(cubit.state.resendIn, VerifyCodeCubit.resendCooldown);
    expect(cubit.state.canResend, isFalse);
  });
}
