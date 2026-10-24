part of 'individual_info_cubit.dart';

class IndividualInfoState extends Equatable {
  const IndividualInfoState({this.idType, this.nationality, this.dateOfBirth, this.gender});

  final IdType? idType;
  final Country? nationality;
  final DateTime? dateOfBirth;
  final Gender? gender;

  IndividualInfoState copyWith({
    IdType? idType,
    Country? nationality,
    DateTime? dateOfBirth,
    Gender? gender,
  }) {
    return IndividualInfoState(
      idType: idType ?? this.idType,
      nationality: nationality ?? this.nationality,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
    );
  }

  @override
  List<Object?> get props => [idType, nationality?.countryCode, dateOfBirth, gender];
}
