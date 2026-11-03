import 'package:flutter_hr_erb/features/auth/data/model/verification_method.dart';
import 'package:flutter_hr_erb/features/auth/data/model/verify_account_args.dart';
import 'package:flutter_hr_erb/features/auth/data/model/verify_code_args.dart';
import 'package:flutter_hr_erb/features/auth/presentation/controller/verify_code_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late VerifyCodeCubit cubit;

  setUp(() => cubit = VerifyCodeCubit());

  tearDown(() => cubit.close());

  test('masks the destination', () {
    const args = VerifyCodeArgs(
      method: VerificationMethod.sms,
      account: VerifyAccountArgs(phoneCode: '20', phone: '1012345678', email: 'nada@gmail.com'),
    );
    expect(args.maskedDestination, '+20 ••• ••• 5678');
  });

  test('cannot verify until the code is complete', () {
    cubit.codeChanged('123');
    expect(cubit.state.canVerify, isFalse);
    cubit.codeChanged('123456');
    expect(cubit.state.canVerify, isTrue);
  });

  test('starting the countdown blocks resend', () {
    cubit.startCountdown();
    expect(cubit.state.resendIn, VerifyCodeCubit.resendCooldown);
    expect(cubit.state.canResend, isFalse);
    expect(cubit.state.expiresIn, VerifyCodeCubit.codeLifetime);
  });

  testWidgets('resend is allowed after the cooldown and clears the code', (tester) async {
    final cubit = VerifyCodeCubit()..startCountdown();
    cubit.codeChanged('123456');

    cubit.resendCode();
    expect(cubit.state.code, '123456');

    await tester.pump(const Duration(seconds: VerifyCodeCubit.resendCooldown));
    expect(cubit.state.canResend, isTrue);

    cubit.resendCode();
    expect(cubit.state.code, isEmpty);
    expect(cubit.state.resendIn, VerifyCodeCubit.resendCooldown);
    await cubit.close();
  });

  testWidgets('an expired code cannot be verified', (tester) async {
    final cubit = VerifyCodeCubit()..startCountdown();
    cubit.codeChanged('123456');
    expect(cubit.state.canVerify, isTrue);

    await tester.pump(const Duration(seconds: VerifyCodeCubit.codeLifetime));
    expect(cubit.state.isExpired, isTrue);
    expect(cubit.state.canVerify, isFalse);
    await cubit.close();
  });

  testWidgets('resending renews the code lifetime', (tester) async {
    final cubit = VerifyCodeCubit()..startCountdown();

    await tester.pump(const Duration(seconds: VerifyCodeCubit.resendCooldown));
    expect(cubit.state.expiresIn, VerifyCodeCubit.codeLifetime - VerifyCodeCubit.resendCooldown);

    cubit.resendCode();
    expect(cubit.state.expiresIn, VerifyCodeCubit.codeLifetime);
    await cubit.close();
  });
}
