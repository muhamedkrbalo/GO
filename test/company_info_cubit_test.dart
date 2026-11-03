import 'package:country_picker/country_picker.dart';
import 'package:flutter_hr_erb/features/owner_registration/data/model/legal_form.dart';
import 'package:flutter_hr_erb/features/owner_registration/presentation/controller/company_info_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CompanyInfoCubit cubit;

  setUp(() => cubit = CompanyInfoCubit());

  tearDown(() => cubit.close());

  test('defaults the phone country to Egypt', () {
    expect(cubit.state.phoneCountry.countryCode, 'EG');
  });

  test('cannot continue until all required fields are filled', () {
    expect(cubit.state.canContinue, isFalse);

    cubit.legalNameChanged('GO Holdings');
    expect(cubit.state.canContinue, isFalse);

    cubit.registrationNumberChanged('123456');
    expect(cubit.state.canContinue, isFalse);

    cubit.selectRegistrationCountry(Country.parse('EG'));
    expect(cubit.state.canContinue, isTrue);
  });

  test('blank required text does not allow continuing', () {
    cubit
      ..legalNameChanged('  ')
      ..registrationNumberChanged('123456')
      ..selectRegistrationCountry(Country.parse('EG'));
    expect(cubit.state.canContinue, isFalse);
  });

  test('legal form is optional', () {
    cubit
      ..legalNameChanged('GO Holdings')
      ..registrationNumberChanged('123456')
      ..selectRegistrationCountry(Country.parse('AE'));
    expect(cubit.state.legalForm, isNull);
    expect(cubit.state.canContinue, isTrue);

    cubit.selectLegalForm(LegalForm.jointStock);
    expect(cubit.state.legalForm, LegalForm.jointStock);
  });

  test('selecting a phone country updates the state', () {
    cubit.selectPhoneCountry(Country.parse('SA'));
    expect(cubit.state.phoneCountry.countryCode, 'SA');
  });
}
