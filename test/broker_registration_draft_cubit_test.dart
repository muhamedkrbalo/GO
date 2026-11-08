import 'package:country_picker/country_picker.dart';
import 'package:flutter_hr_erb/core/enum/id_type.dart';
import 'package:flutter_hr_erb/features/broker_registration/data/model/broker_type.dart';
import 'package:flutter_hr_erb/features/broker_registration/presentation/controller/broker_identity_info_cubit.dart';
import 'package:flutter_hr_erb/features/broker_registration/presentation/controller/broker_personal_info_cubit.dart';
import 'package:flutter_hr_erb/features/broker_registration/presentation/controller/broker_registration_draft_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late BrokerRegistrationDraftCubit cubit;

  setUp(() => cubit = BrokerRegistrationDraftCubit());

  tearDown(() => cubit.close());

  BrokerPersonalInfoState personalInfo({
    String mobile = '1024055926',
    String email = 'nada@gmail.com',
  }) {
    return BrokerPersonalInfoState(
      phoneCountry: Country.parse('EG'),
      fullName: 'Nada Ali',
      mobileNumber: mobile,
      email: email,
    );
  }

  test('starts empty with no business contacts', () {
    expect(cubit.state.brokerType, isNull);
    expect(cubit.state.businessMobile, isNull);
    expect(cubit.state.businessEmail, isNull);
  });

  test('business contacts come from the saved personal info', () {
    cubit.savePersonalInfo(personalInfo());

    expect(cubit.state.businessMobile, '+20 1024055926');
    expect(cubit.state.businessEmail, 'nada@gmail.com');
  });

  test('blank mobile and email are reported as not provided', () {
    cubit.savePersonalInfo(personalInfo(mobile: '  ', email: ''));

    expect(cubit.state.businessMobile, isNull);
    expect(cubit.state.businessEmail, isNull);
  });

  test('switching broker type starts a fresh draft', () {
    cubit
      ..startRegistration(BrokerType.individual)
      ..savePersonalInfo(personalInfo())
      ..startRegistration(BrokerType.company);

    expect(cubit.state.brokerType, BrokerType.company);
    expect(cubit.state.personalInfo, isNull);
  });

  test('restarting with the same broker type keeps saved steps', () {
    cubit
      ..startRegistration(BrokerType.individual)
      ..savePersonalInfo(personalInfo())
      ..saveIdentityInfo(const BrokerIdentityInfoState(idType: IdType.passport, idNumber: 'A1'))
      ..startRegistration(BrokerType.individual);

    expect(cubit.state.personalInfo, isNotNull);
    expect(cubit.state.identityInfo?.idType, IdType.passport);
  });

  test('clear resets the draft', () {
    cubit
      ..startRegistration(BrokerType.individual)
      ..savePersonalInfo(personalInfo())
      ..clear();

    expect(cubit.state, const BrokerRegistrationDraft());
  });
}
