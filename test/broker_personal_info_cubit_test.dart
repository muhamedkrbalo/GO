import 'package:country_picker/country_picker.dart';
import 'package:flutter_hr_erb/features/broker_registration/presentation/controller/broker_personal_info_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late BrokerPersonalInfoCubit cubit;

  setUp(() => cubit = BrokerPersonalInfoCubit());

  tearDown(() => cubit.close());

  void fillAllFields() {
    cubit
      ..fullNameChanged('Mona Adel')
      ..selectNationality(Country.parse('EG'))
      ..mobileNumberChanged('1001234567')
      ..emailChanged('mona@example.com');
  }

  test('starts empty with Egypt as the phone country', () {
    expect(cubit.state.fullName, isEmpty);
    expect(cubit.state.nationality, isNull);
    expect(cubit.state.phoneCountry.countryCode, 'EG');
    expect(cubit.state.canContinue, isFalse);
  });

  test('canContinue is true once every required field is filled', () {
    fillAllFields();

    expect(cubit.state.canContinue, isTrue);
  });

  test('canContinue stays false when nationality is missing', () {
    cubit
      ..fullNameChanged('Mona Adel')
      ..mobileNumberChanged('1001234567')
      ..emailChanged('mona@example.com');

    expect(cubit.state.canContinue, isFalse);
  });

  test('whitespace-only name does not count as filled', () {
    fillAllFields();
    cubit.fullNameChanged('   ');

    expect(cubit.state.canContinue, isFalse);
  });

  test('selectPhoneCountry replaces the phone country', () {
    cubit.selectPhoneCountry(Country.parse('SA'));

    expect(cubit.state.phoneCountry.countryCode, 'SA');
  });

  test('restores a previously saved state', () {
    final restored = BrokerPersonalInfoCubit(
      initialState: BrokerPersonalInfoState(
        phoneCountry: Country.parse('SA'),
        fullName: 'Mona Adel',
      ),
    );
    addTearDown(restored.close);

    expect(restored.state.fullName, 'Mona Adel');
    expect(restored.state.phoneCountry.countryCode, 'SA');
  });
}
