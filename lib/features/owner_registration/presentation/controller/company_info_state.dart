part of 'company_info_cubit.dart';

class CompanyInfoState extends Equatable {
  const CompanyInfoState({
    required this.phoneCountry,
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
  }) {
    return CompanyInfoState(
      legalName: legalName ?? this.legalName,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      legalForm: legalForm ?? this.legalForm,
      registrationCountry: registrationCountry ?? this.registrationCountry,
      phoneCountry: phoneCountry ?? this.phoneCountry,
    );
  }

  @override
  List<Object?> get props => [
    legalName,
    registrationNumber,
    legalForm,
    registrationCountry?.countryCode,
    phoneCountry.countryCode,
  ];
}
