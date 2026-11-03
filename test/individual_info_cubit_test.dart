import 'package:country_picker/country_picker.dart';
import 'package:flutter_hr_erb/features/owner_registration/data/model/id_type.dart';
import 'package:flutter_hr_erb/features/owner_registration/presentation/controller/individual_info_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late IndividualInfoCubit cubit;

  setUp(() => cubit = IndividualInfoCubit());

  tearDown(() => cubit.close());

  test('defaults the phone country to Egypt', () {
    expect(cubit.state.phoneCountry.countryCode, 'EG');
  });

  test('cannot continue until all required fields are filled', () {
    expect(cubit.state.canContinue, isFalse);

    cubit.fullNameChanged('Nada Ali');
    expect(cubit.state.canContinue, isFalse);

    cubit.selectIdType(IdType.nationalId);
    expect(cubit.state.canContinue, isFalse);

    cubit.idNumberChanged('29801011234567');
    expect(cubit.state.canContinue, isTrue);
  });

  test('blank required text does not allow continuing', () {
    cubit
      ..fullNameChanged('   ')
      ..selectIdType(IdType.passport)
      ..idNumberChanged('A1234567');
    expect(cubit.state.canContinue, isFalse);
  });

  test('optional fields do not affect continuing', () {
    cubit
      ..fullNameChanged('Nada Ali')
      ..selectIdType(IdType.passport)
      ..idNumberChanged('A1234567');
    expect(cubit.state.nationality, isNull);
    expect(cubit.state.canContinue, isTrue);
  });

  test('selecting a phone country updates the state', () {
    cubit.selectPhoneCountry(Country.parse('SA'));
    expect(cubit.state.phoneCountry.countryCode, 'SA');
  });
}
