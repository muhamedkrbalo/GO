part of 'broker_representative_cubit.dart';

class BrokerRepresentativeState extends Equatable {
  const BrokerRepresentativeState({
    required this.phoneCountry,
    this.fullName = '',
    this.idType,
    this.idNumber = '',
    this.mobileNumber = '',
    this.email = '',
    this.proofOfAuthorization,
  });

  final String fullName;
  final IdType? idType;
  final String idNumber;
  final Country phoneCountry;
  final String mobileNumber;
  final String email;
  final UploadedDocument? proofOfAuthorization;

  bool get canContinue =>
      fullName.trim().isNotEmpty &&
      idType != null &&
      idNumber.trim().isNotEmpty &&
      mobileNumber.trim().isNotEmpty &&
      email.trim().isNotEmpty &&
      proofOfAuthorization != null;

  BrokerRepresentativeState copyWith({
    String? fullName,
    IdType? idType,
    String? idNumber,
    Country? phoneCountry,
    String? mobileNumber,
    String? email,
    UploadedDocument? proofOfAuthorization,
  }) {
    return BrokerRepresentativeState(
      fullName: fullName ?? this.fullName,
      idType: idType ?? this.idType,
      idNumber: idNumber ?? this.idNumber,
      phoneCountry: phoneCountry ?? this.phoneCountry,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      email: email ?? this.email,
      proofOfAuthorization: proofOfAuthorization ?? this.proofOfAuthorization,
    );
  }

  BrokerRepresentativeState withoutProof() {
    return BrokerRepresentativeState(
      fullName: fullName,
      idType: idType,
      idNumber: idNumber,
      phoneCountry: phoneCountry,
      mobileNumber: mobileNumber,
      email: email,
    );
  }

  @override
  List<Object?> get props => [
    fullName,
    idType,
    idNumber,
    phoneCountry.countryCode,
    mobileNumber,
    email,
    proofOfAuthorization,
  ];
}
