import 'package:country_picker/country_picker.dart';
import 'package:flutter_hr_erb/core/enum/legal_form.dart';
import 'package:flutter_hr_erb/features/broker_registration/presentation/controller/broker_company_info_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late BrokerCompanyInfoCubit cubit;

  setUp(() => cubit = BrokerCompanyInfoCubit());

  tearDown(() => cubit.close());

  void fillRequiredFields() {
    cubit
      ..legalNameChanged('Rooftop Regency LLC')
      ..registrationNumberChanged('CR-102938')
      ..selectLegalForm(LegalForm.limitedLiability)
      ..selectRegistrationDate(DateTime(2019, 5, 14))
      ..selectRegistrationCountry(Country.parse('EG'))
      ..mobileNumberChanged('1024055926')
      ..emailChanged('info@rooftop.com');
  }

  test('starts empty with Egypt as the phone country', () {
    expect(cubit.state.legalName, isEmpty);
    expect(cubit.state.phoneCountry.countryCode, 'EG');
    expect(cubit.state.canContinue, isFalse);
  });

  test('canContinue is true once every required field is filled', () {
    fillRequiredFields();

    expect(cubit.state.canContinue, isTrue);
  });

  test('trade name and tax number are optional', () {
    fillRequiredFields();

    expect(cubit.state.tradeName, isEmpty);
    expect(cubit.state.taxNumber, isEmpty);
    expect(cubit.state.canContinue, isTrue);
  });

  test('registration date is required', () {
    cubit
      ..legalNameChanged('Rooftop Regency LLC')
      ..registrationNumberChanged('CR-102938')
      ..selectLegalForm(LegalForm.limitedLiability)
      ..selectRegistrationCountry(Country.parse('EG'))
      ..mobileNumberChanged('1024055926')
      ..emailChanged('info@rooftop.com');

    expect(cubit.state.canContinue, isFalse);
  });

  test('selectRegistrationDate drops the time of day', () {
    cubit.selectRegistrationDate(DateTime(2019, 5, 14, 17, 45));

    expect(cubit.state.registrationDate, DateTime(2019, 5, 14));
  });

  test('restores a previously saved state', () {
    final restored = BrokerCompanyInfoCubit(
      initialState: BrokerCompanyInfoState(
        phoneCountry: Country.parse('SA'),
        legalName: 'Rooftop Regency LLC',
      ),
    );
    addTearDown(restored.close);

    expect(restored.state.legalName, 'Rooftop Regency LLC');
    expect(restored.state.phoneCountry.countryCode, 'SA');
  });
}
