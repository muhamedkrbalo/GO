part of 'broker_registration_draft_cubit.dart';

class BrokerRegistrationDraft extends Equatable {
  const BrokerRegistrationDraft({
    this.brokerType,
    this.personalInfo,
    this.identityInfo,
    this.businessAddress,
  });

  final BrokerType? brokerType;
  final BrokerPersonalInfoState? personalInfo;
  final BrokerIdentityInfoState? identityInfo;
  final BrokerBusinessAddressState? businessAddress;

  String? get businessMobile {
    final info = personalInfo;
    if (info == null || info.mobileNumber.trim().isEmpty) return null;
    return '+${info.phoneCountry.phoneCode} ${info.mobileNumber.trim()}';
  }

  String? get businessEmail {
    final email = personalInfo?.email.trim();
    return email == null || email.isEmpty ? null : email;
  }

  BrokerRegistrationDraft copyWith({
    BrokerPersonalInfoState? personalInfo,
    BrokerIdentityInfoState? identityInfo,
    BrokerBusinessAddressState? businessAddress,
  }) {
    return BrokerRegistrationDraft(
      brokerType: brokerType,
      personalInfo: personalInfo ?? this.personalInfo,
      identityInfo: identityInfo ?? this.identityInfo,
      businessAddress: businessAddress ?? this.businessAddress,
    );
  }

  @override
  List<Object?> get props => [brokerType, personalInfo, identityInfo, businessAddress];
}
