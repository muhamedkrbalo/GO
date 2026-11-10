import 'package:flutter_hr_erb/core/models/uploaded_document.dart';
import 'package:flutter_hr_erb/features/owner_packages/data/model/payment_method.dart';
import 'package:flutter_hr_erb/features/owner_packages/presentation/controller/package_payment_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

const _proof = UploadedDocument(name: 'receipt.pdf', sizeInBytes: 2048, path: '/tmp/receipt.pdf');

void main() {
  late PackagePaymentCubit cubit;

  setUp(() => cubit = PackagePaymentCubit());

  tearDown(() => cubit.close());

  test('starts empty and cannot submit', () {
    expect(cubit.state, const PackagePaymentState());
    expect(cubit.state.hasMethod, isFalse);
    expect(cubit.state.canSubmit, isFalse);
  });

  test('selectMethod sets the method and replaces a previous one', () {
    cubit
      ..selectMethod(PaymentMethod.bankTransfer)
      ..selectMethod(PaymentMethod.instaPay);

    expect(cubit.state.method, PaymentMethod.instaPay);
    expect(cubit.state.hasMethod, isTrue);
  });

  test('selecting the already selected method emits nothing', () async {
    cubit.selectMethod(PaymentMethod.fawry);
    final emitted = <PackagePaymentState>[];
    final subscription = cubit.stream.listen(emitted.add);

    cubit.selectMethod(PaymentMethod.fawry);
    await Future<void>.delayed(Duration.zero);

    expect(emitted, isEmpty);
    await subscription.cancel();
  });

  test('cannot submit with a method but no reference', () {
    cubit.selectMethod(PaymentMethod.instaPay);

    expect(cubit.state.canSubmit, isFalse);
  });

  test('a blank reference does not allow submit', () {
    cubit
      ..selectMethod(PaymentMethod.instaPay)
      ..updateReference('   ');

    expect(cubit.state.canSubmit, isFalse);
  });

  test('cannot submit with a reference but no method', () {
    cubit.updateReference('REF-123');

    expect(cubit.state.canSubmit, isFalse);
  });

  test('can submit with a method and a reference', () {
    cubit
      ..selectMethod(PaymentMethod.instaPay)
      ..updateReference('REF-123');

    expect(cubit.state.reference, 'REF-123');
    expect(cubit.state.canSubmit, isTrue);
  });

  test('changing the method keeps the reference and proof', () {
    cubit
      ..selectMethod(PaymentMethod.instaPay)
      ..updateReference('REF-123')
      ..attachProof(_proof)
      ..selectMethod(PaymentMethod.fawry);

    expect(cubit.state.reference, 'REF-123');
    expect(cubit.state.proof, _proof);
  });

  test('attachProof stores the file and removeProof clears it', () {
    cubit.attachProof(_proof);
    expect(cubit.state.proof, _proof);

    cubit.removeProof();
    expect(cubit.state.proof, isNull);
  });

  test('removeProof without a proof emits nothing', () async {
    final emitted = <PackagePaymentState>[];
    final subscription = cubit.stream.listen(emitted.add);

    cubit.removeProof();
    await Future<void>.delayed(Duration.zero);

    expect(emitted, isEmpty);
    await subscription.cancel();
  });
}
