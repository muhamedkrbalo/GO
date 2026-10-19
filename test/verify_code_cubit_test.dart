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

  test('starting the cooldown blocks resend', () {
    cubit.startResendCooldown();
    expect(cubit.state.resendIn, VerifyCodeCubit.resendCooldown);
    expect(cubit.state.canResend, isFalse);
  });

  testWidgets('resend is allowed after the cooldown and clears the code', (tester) async {
    final cubit = VerifyCodeCubit()..startResendCooldown();
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
}
