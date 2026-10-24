import 'package:flutter_hr_erb/features/auth/data/model/verification_method.dart';
import 'package:flutter_hr_erb/features/auth/presentation/controller/verify_account_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late VerifyAccountCubit cubit;

  setUp(() => cubit = VerifyAccountCubit());

  tearDown(() => cubit.close());

  test('starts with no method selected and cannot continue', () {
    expect(cubit.state.method, isNull);
    expect(cubit.state.canContinue, isFalse);
  });

  test('selecting a method allows continuing', () {
    cubit.selectMethod(VerificationMethod.email);
    expect(cubit.state.method, VerificationMethod.email);
    expect(cubit.state.canContinue, isTrue);
  });

  test('sendCode does nothing without a selected method', () {
    cubit.sendCode();
    expect(cubit.state.isCodeSent, isFalse);
  });

  test('sendCode marks the code as sent and blocks continuing', () {
    cubit
      ..selectMethod(VerificationMethod.sms)
      ..sendCode();
    expect(cubit.state.isCodeSent, isTrue);
    expect(cubit.state.canContinue, isFalse);
  });

  test('the method cannot change after the code is sent', () {
    cubit
      ..selectMethod(VerificationMethod.sms)
      ..sendCode()
      ..selectMethod(VerificationMethod.email);
    expect(cubit.state.method, VerificationMethod.sms);
  });

  test('resetCodeSent keeps the method and allows continuing again', () {
    cubit
      ..selectMethod(VerificationMethod.sms)
      ..sendCode()
      ..resetCodeSent();
    expect(cubit.state.method, VerificationMethod.sms);
    expect(cubit.state.canContinue, isTrue);
  });
}
