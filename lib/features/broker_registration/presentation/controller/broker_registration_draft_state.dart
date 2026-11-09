part of 'broker_registration_draft_cubit.dart';

class BrokerRegistrationDraft extends Equatable {
  const BrokerRegistrationDraft({
    this.brokerType,
    this.personalInfo,
    this.companyInfo,
    this.identityInfo,
    this.representative,
    this.businessAddress,
    this.documents = const {},
  });

  final BrokerType? brokerType;
  final BrokerPersonalInfoState? personalInfo;
  final BrokerCompanyInfoState? companyInfo;
  final BrokerIdentityInfoState? identityInfo;
  final BrokerRepresentativeState? representative;
  final BrokerBusinessAddressState? businessAddress;
  final Map<BrokerDocumentType, UploadedDocument> documents;

  bool get isCompany => brokerType == BrokerType.company;

  String? get businessMobile {
    final (country, mobile) = isCompany
        ? (companyInfo?.phoneCountry, companyInfo?.mobileNumber.trim())
        : (personalInfo?.phoneCountry, personalInfo?.mobileNumber.trim());
    if (country == null || mobile == null || mobile.isEmpty) return null;
    return '+${country.phoneCode} $mobile';
  }

  String? get businessEmail {
    final email = (isCompany ? companyInfo?.email : personalInfo?.email)?.trim();
    return email == null || email.isEmpty ? null : email;
  }

  bool get isEntityInfoComplete => isCompany
      ? (companyInfo?.canContinue ?? false) && (representative?.canContinue ?? false)
      : (personalInfo?.canContinue ?? false);

  int get businessAddressStep => isCompany ? 5 : 4;

  int get businessContactStep => isCompany ? 6 : 5;

  bool get isReadyToSubmit =>
      isEntityInfoComplete &&
      (identityInfo?.canContinue ?? false) &&
      (businessAddress?.canContinue ?? false) &&
      BrokerDocumentType.values.where((type) => type.isRequired).every(documents.containsKey);

  BrokerRegistrationDraft copyWith({
    BrokerPersonalInfoState? personalInfo,
    BrokerCompanyInfoState? companyInfo,
    BrokerIdentityInfoState? identityInfo,
    BrokerRepresentativeState? representative,
    BrokerBusinessAddressState? businessAddress,
    Map<BrokerDocumentType, UploadedDocument>? documents,
  }) {
    return BrokerRegistrationDraft(
      brokerType: brokerType,
      personalInfo: personalInfo ?? this.personalInfo,
      companyInfo: companyInfo ?? this.companyInfo,
      identityInfo: identityInfo ?? this.identityInfo,
      representative: representative ?? this.representative,
      businessAddress: businessAddress ?? this.businessAddress,
      documents: documents ?? this.documents,
    );
  }

  @override
  List<Object?> get props => [
    brokerType,
    personalInfo,
    companyInfo,
    identityInfo,
    representative,
    businessAddress,
    documents,
  ];
}
