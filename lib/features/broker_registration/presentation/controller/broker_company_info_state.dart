part of 'broker_company_info_cubit.dart';

class BrokerCompanyInfoState extends Equatable {
  const BrokerCompanyInfoState({
    required this.phoneCountry,
    this.legalName = '',
    this.tradeName = '',
    this.registrationNumber = '',
    this.taxNumber = '',
    this.legalForm,
    this.registrationDate,
    this.registrationCountry,
    this.mobileNumber = '',
    this.email = '',
  });

  final String legalName;
  final String tradeName;
  final String registrationNumber;
  final String taxNumber;
  final LegalForm? legalForm;
  final DateTime? registrationDate;
  final Country? registrationCountry;
  final Country phoneCountry;
  final String mobileNumber;
  final String email;

  bool get canContinue =>
      legalName.trim().isNotEmpty &&
      registrationNumber.trim().isNotEmpty &&
      legalForm != null &&
      registrationDate != null &&
      registrationCountry != null &&
      mobileNumber.trim().isNotEmpty &&
      email.trim().isNotEmpty;

  BrokerCompanyInfoState copyWith({
    String? legalName,
    String? tradeName,
    String? registrationNumber,
    String? taxNumber,
    LegalForm? legalForm,
    DateTime? registrationDate,
    Country? registrationCountry,
    Country? phoneCountry,
    String? mobileNumber,
    String? email,
  }) {
    return BrokerCompanyInfoState(
      legalName: legalName ?? this.legalName,
      tradeName: tradeName ?? this.tradeName,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      taxNumber: taxNumber ?? this.taxNumber,
      legalForm: legalForm ?? this.legalForm,
      registrationDate: registrationDate ?? this.registrationDate,
      registrationCountry: registrationCountry ?? this.registrationCountry,
      phoneCountry: phoneCountry ?? this.phoneCountry,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [
    legalName,
    tradeName,
    registrationNumber,
    taxNumber,
    legalForm,
    registrationDate,
    registrationCountry?.countryCode,
    phoneCountry.countryCode,
    mobileNumber,
    email,
  ];
}
