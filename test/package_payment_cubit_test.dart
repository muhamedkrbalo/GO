import 'package:flutter_hr_erb/features/owner_packages/data/model/payment_method.dart';
import 'package:flutter_hr_erb/features/owner_packages/presentation/controller/package_payment_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late PackagePaymentCubit cubit;

  setUp(() => cubit = PackagePaymentCubit());

  tearDown(() => cubit.close());

  test('starts with no payment method selected', () {
    expect(cubit.state, isNull);
  });

  test('selectMethod emits the chosen method', () {
    cubit.selectMethod(PaymentMethod.instaPay);

    expect(cubit.state, PaymentMethod.instaPay);
  });

  test('selecting another method replaces the previous one', () {
    cubit
      ..selectMethod(PaymentMethod.bankTransfer)
      ..selectMethod(PaymentMethod.fawry);

    expect(cubit.state, PaymentMethod.fawry);
  });

  test('selecting the already selected method emits nothing', () async {
    cubit.selectMethod(PaymentMethod.fawry);
    final emitted = <PaymentMethod?>[];
    final subscription = cubit.stream.listen(emitted.add);

    cubit.selectMethod(PaymentMethod.fawry);
    await Future<void>.delayed(Duration.zero);

    expect(emitted, isEmpty);
    await subscription.cancel();
  });
}
