import 'package:country_picker/country_picker.dart';
import 'package:flutter_hr_erb/features/owner_registration/data/model/address_type.dart';
import 'package:flutter_hr_erb/features/owner_registration/presentation/controller/owner_address_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late OwnerAddressCubit cubit;

  setUp(() => cubit = OwnerAddressCubit());

  tearDown(() => cubit.close());

  test('starts as a residential primary address', () {
    expect(cubit.state.type, AddressType.residential);
    expect(cubit.state.isPrimary, isTrue);
  });

  test('governorate unlocks after a country and city after a governorate', () {
    expect(cubit.state.canEnterGovernorate, isFalse);
    expect(cubit.state.canEnterCity, isFalse);

    cubit.selectCountry(Country.parse('EG'));
    expect(cubit.state.canEnterGovernorate, isTrue);
    expect(cubit.state.canEnterCity, isFalse);

    cubit.governorateChanged('Cairo');
    expect(cubit.state.canEnterCity, isTrue);
  });

  test('changing the country clears governorate and city', () {
    cubit
      ..selectCountry(Country.parse('EG'))
      ..governorateChanged('Cairo')
      ..cityChanged('Nasr City')
      ..selectCountry(Country.parse('SA'));
    expect(cubit.state.governorate, isEmpty);
    expect(cubit.state.city, isEmpty);
    expect(cubit.state.canEnterCity, isFalse);
  });

  test('reselecting the same country keeps governorate and city', () {
    cubit
      ..selectCountry(Country.parse('EG'))
      ..governorateChanged('Cairo')
      ..selectCountry(Country.parse('EG'));
    expect(cubit.state.governorate, 'Cairo');
  });

  test('can continue only with a country and address line 1', () {
    expect(cubit.state.canContinue, isFalse);

    cubit.addressLine1Changed('12 Tahrir St');
    expect(cubit.state.canContinue, isFalse);

    cubit.selectCountry(Country.parse('EG'));
    expect(cubit.state.canContinue, isTrue);

    cubit.addressLine1Changed('   ');
    expect(cubit.state.canContinue, isFalse);
  });

  test('updates address type and primary flag', () {
    cubit
      ..selectType(AddressType.business)
      ..togglePrimary(false);
    expect(cubit.state.type, AddressType.business);
    expect(cubit.state.isPrimary, isFalse);
  });
}
