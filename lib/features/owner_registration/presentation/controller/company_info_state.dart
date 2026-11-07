part of 'company_info_cubit.dart';

class CompanyInfoState extends Equatable {
  const CompanyInfoState({
    required this.phoneCountry,
    this.mobileNumber = '',
    this.email = '',
    this.legalName = '',
    this.registrationNumber = '',
    this.legalForm,
    this.registrationCountry,
  });

  final String legalName;
  final String registrationNumber;
  final LegalForm? legalForm;
  final Country? registrationCountry;
  final Country phoneCountry;
  final String mobileNumber;
  final String email;

  bool get canContinue =>
      legalName.trim().isNotEmpty &&
      registrationNumber.trim().isNotEmpty &&
      registrationCountry != null;

  CompanyInfoState copyWith({
    String? legalName,
    String? registrationNumber,
    LegalForm? legalForm,
    Country? registrationCountry,
    Country? phoneCountry,
    String? mobileNumber,
    String? email,
  }) {
    return CompanyInfoState(
      legalName: legalName ?? this.legalName,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      legalForm: legalForm ?? this.legalForm,
      registrationCountry: registrationCountry ?? this.registrationCountry,
      phoneCountry: phoneCountry ?? this.phoneCountry,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [
    legalName,
    registrationNumber,
    legalForm,
    registrationCountry?.countryCode,
    phoneCountry.countryCode,
    mobileNumber,
    email,
  ];
}
