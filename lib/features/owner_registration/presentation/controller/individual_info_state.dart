part of 'individual_info_cubit.dart';

class IndividualInfoState extends Equatable {
  const IndividualInfoState({
    required this.phoneCountry,
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

  bool get canContinue =>
      fullName.trim().isNotEmpty && idType != null && idNumber.trim().isNotEmpty;

  IndividualInfoState copyWith({
    String? fullName,
    IdType? idType,
    String? idNumber,
    Country? nationality,
    Country? phoneCountry,
  }) {
    return IndividualInfoState(
      fullName: fullName ?? this.fullName,
      idType: idType ?? this.idType,
      idNumber: idNumber ?? this.idNumber,
      nationality: nationality ?? this.nationality,
      phoneCountry: phoneCountry ?? this.phoneCountry,
    );
  }

  @override
  List<Object?> get props => [
    fullName,
    idType,
    idNumber,
    nationality?.countryCode,
    phoneCountry.countryCode,
  ];
}
