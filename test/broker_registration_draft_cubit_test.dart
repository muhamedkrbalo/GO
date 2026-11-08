import 'package:country_picker/country_picker.dart';
import 'package:flutter_hr_erb/core/enum/id_type.dart';
import 'package:flutter_hr_erb/core/enum/legal_form.dart';
import 'package:flutter_hr_erb/core/models/uploaded_document.dart';
import 'package:flutter_hr_erb/features/broker_registration/data/model/broker_document_type.dart';
import 'package:flutter_hr_erb/features/broker_registration/data/model/broker_type.dart';
import 'package:flutter_hr_erb/features/broker_registration/presentation/controller/broker_business_address_cubit.dart';
import 'package:flutter_hr_erb/features/broker_registration/presentation/controller/broker_company_info_cubit.dart';
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

  group('isReadyToSubmit', () {
    void fillEverything() {
      cubit
        ..startRegistration(BrokerType.individual)
        ..savePersonalInfo(
          BrokerPersonalInfoState(
            phoneCountry: Country.parse('EG'),
            fullName: 'Nada Ali',
            nationality: Country.parse('EG'),
            mobileNumber: '1024055926',
            email: 'nada@gmail.com',
          ),
        )
        ..saveIdentityInfo(const BrokerIdentityInfoState(idType: IdType.passport, idNumber: 'A1'))
        ..saveBusinessAddress(
          BrokerBusinessAddressState(
            country: Country.parse('EG'),
            governorate: 'Cairo',
            city: 'Nasr City',
            addressLine1: '12 Abbas St',
          ),
        )
        ..saveDocuments({
          BrokerDocumentType.identityFront: const UploadedDocument(name: 'f.png', sizeInBytes: 1),
        });
    }

    test('is true when every step is complete', () {
      fillEverything();

      expect(cubit.state.isReadyToSubmit, isTrue);
    });

    test('is false when the required document is missing', () {
      fillEverything();
      cubit.saveDocuments({
        BrokerDocumentType.identityBack: const UploadedDocument(name: 'b.png', sizeInBytes: 1),
      });

      expect(cubit.state.isReadyToSubmit, isFalse);
    });

    test('is false when a step was skipped', () {
      fillEverything();
      cubit.saveIdentityInfo(const BrokerIdentityInfoState());

      expect(cubit.state.isReadyToSubmit, isFalse);
    });
  });

  group('company broker', () {
    final company = BrokerCompanyInfoState(
      phoneCountry: Country.parse('EG'),
      legalName: 'Rooftop Regency LLC',
      registrationNumber: 'CR-102938',
      legalForm: LegalForm.limitedLiability,
      registrationDate: DateTime(2019, 5, 14),
      registrationCountry: Country.parse('EG'),
      mobileNumber: '1011112222',
      email: 'info@rooftop.com',
    );

    test('business contacts come from the company info', () {
      cubit
        ..startRegistration(BrokerType.company)
        ..savePersonalInfo(personalInfo())
        ..saveCompanyInfo(company);

      expect(cubit.state.businessMobile, '+20 1011112222');
      expect(cubit.state.businessEmail, 'info@rooftop.com');
    });

    test('entity info is complete from the company step, not the personal one', () {
      cubit
        ..startRegistration(BrokerType.company)
        ..savePersonalInfo(personalInfo());
      expect(cubit.state.isEntityInfoComplete, isFalse);

      cubit.saveCompanyInfo(company);
      expect(cubit.state.isEntityInfoComplete, isTrue);
    });
  });
}
