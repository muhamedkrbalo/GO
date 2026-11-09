import 'package:country_picker/country_picker.dart';
import 'package:flutter_hr_erb/core/enum/id_type.dart';
import 'package:flutter_hr_erb/core/models/uploaded_document.dart';
import 'package:flutter_hr_erb/features/broker_registration/presentation/controller/broker_representative_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late BrokerRepresentativeCubit cubit;

  const proof = UploadedDocument(name: 'authorization.pdf', sizeInBytes: 2048);

  setUp(() => cubit = BrokerRepresentativeCubit());

  tearDown(() => cubit.close());

  void fillRequiredFields() {
    cubit
      ..fullNameChanged('Omar Hassan')
      ..selectIdType(IdType.nationalId)
      ..idNumberChanged('29801011234567')
      ..mobileNumberChanged('1024055926')
      ..emailChanged('omar@rooftop.com')
      ..attachProof(proof);
  }

  test('starts empty and cannot continue', () {
    expect(cubit.state.phoneCountry.countryCode, 'EG');
    expect(cubit.state.proofOfAuthorization, isNull);
    expect(cubit.state.canContinue, isFalse);
  });

  test('canContinue needs every field and the proof document', () {
    fillRequiredFields();
    expect(cubit.state.canContinue, isTrue);

    cubit.removeProof();
    expect(cubit.state.proofOfAuthorization, isNull);
    expect(cubit.state.canContinue, isFalse);
  });

  test('changing the identity type clears the number and keeps the rest', () {
    fillRequiredFields();
    cubit.selectIdType(IdType.passport);

    expect(cubit.state.idType, IdType.passport);
    expect(cubit.state.idNumber, isEmpty);
    expect(cubit.state.fullName, 'Omar Hassan');
    expect(cubit.state.proofOfAuthorization, proof);
  });

  test('removing a missing proof does nothing', () async {
    final emitted = <BrokerRepresentativeState>[];
    final subscription = cubit.stream.listen(emitted.add);

    cubit.removeProof();
    await Future<void>.delayed(Duration.zero);

    expect(emitted, isEmpty);
    await subscription.cancel();
  });

  test('restores a previously saved state', () {
    final restored = BrokerRepresentativeCubit(
      initialState: BrokerRepresentativeState(
        phoneCountry: Country.parse('SA'),
        fullName: 'Omar Hassan',
        proofOfAuthorization: proof,
      ),
    );
    addTearDown(restored.close);

    expect(restored.state.fullName, 'Omar Hassan');
    expect(restored.state.proofOfAuthorization, proof);
  });
}
