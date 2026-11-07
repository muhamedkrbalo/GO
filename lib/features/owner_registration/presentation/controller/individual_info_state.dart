part of 'individual_info_cubit.dart';

class IndividualInfoState extends Equatable {
  const IndividualInfoState({
    required this.phoneCountry,
    this.mobileNumber = '',
    this.email = '',
    this.fullName = '',
    this.idType,
    this.idNumber = '',
    this.nationality,
  });

  final String fullName;
  final IdType? idType;
  final String idNumber;
  final Country? nationality;
  final Country phoneCountry;
  final String mobileNumber;
  final String email;

  bool get canContinue =>
      fullName.trim().isNotEmpty && idType != null && idNumber.trim().isNotEmpty;

  IndividualInfoState copyWith({
    String? fullName,
    IdType? idType,
    String? idNumber,
    Country? nationality,
    Country? phoneCountry,
    String? mobileNumber,
    String? email,
  }) {
    return IndividualInfoState(
      fullName: fullName ?? this.fullName,
      idType: idType ?? this.idType,
      idNumber: idNumber ?? this.idNumber,
      nationality: nationality ?? this.nationality,
      phoneCountry: phoneCountry ?? this.phoneCountry,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [
    fullName,
    idType,
    idNumber,
    nationality?.countryCode,
    phoneCountry.countryCode,
    mobileNumber,
    email,
  ];
}
