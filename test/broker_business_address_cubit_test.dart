import 'package:country_picker/country_picker.dart';
import 'package:flutter_hr_erb/core/enum/address_type.dart';
import 'package:flutter_hr_erb/features/broker_registration/presentation/controller/broker_business_address_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late BrokerBusinessAddressCubit cubit;

  setUp(() => cubit = BrokerBusinessAddressCubit());

  tearDown(() => cubit.close());

  void fillRequiredFields() {
    cubit
      ..selectCountry(Country.parse('EG'))
      ..governorateChanged('Cairo')
      ..cityChanged('Nasr City')
      ..addressLine1Changed('12 Abbas El Akkad St');
  }

  test('starts with business type, primary checked and cannot continue', () {
    expect(cubit.state.type, AddressType.business);
    expect(cubit.state.isPrimary, isTrue);
    expect(cubit.state.canEnterGovernorate, isFalse);
    expect(cubit.state.canContinue, isFalse);
  });

  test('canContinue is true once every required field is filled', () {
    fillRequiredFields();

    expect(cubit.state.canContinue, isTrue);
  });

  test('optional fields are not needed to continue', () {
    fillRequiredFields();

    expect(cubit.state.district, isEmpty);
    expect(cubit.state.addressLine2, isEmpty);
    expect(cubit.state.postalCode, isEmpty);
    expect(cubit.state.canContinue, isTrue);
  });

  test('city is locked until a governorate is entered', () {
    cubit.selectCountry(Country.parse('EG'));
    expect(cubit.state.canEnterGovernorate, isTrue);
    expect(cubit.state.canEnterCity, isFalse);

    cubit.governorateChanged('Cairo');
    expect(cubit.state.canEnterCity, isTrue);
  });

  test('changing the country clears governorate and city only', () {
    fillRequiredFields();
    cubit.selectCountry(Country.parse('SA'));

    expect(cubit.state.country?.countryCode, 'SA');
    expect(cubit.state.governorate, isEmpty);
    expect(cubit.state.city, isEmpty);
    expect(cubit.state.addressLine1, '12 Abbas El Akkad St');
    expect(cubit.state.canContinue, isFalse);
  });

  test('reselecting the same country keeps governorate and city', () {
    fillRequiredFields();
    cubit.selectCountry(Country.parse('EG'));

    expect(cubit.state.governorate, 'Cairo');
    expect(cubit.state.city, 'Nasr City');
  });

  test('selectType and togglePrimary update the state', () {
    cubit
      ..selectType(AddressType.other)
      ..togglePrimary(false);

    expect(cubit.state.type, AddressType.other);
    expect(cubit.state.isPrimary, isFalse);
  });
}
