part of 'broker_identity_info_cubit.dart';

class BrokerIdentityInfoState extends Equatable {
  const BrokerIdentityInfoState({this.idType, this.idNumber = ''});

  final IdType? idType;
  final String idNumber;

  bool get canContinue => idType != null && idNumber.trim().isNotEmpty;

  BrokerIdentityInfoState copyWith({IdType? idType, String? idNumber}) {
    return BrokerIdentityInfoState(
      idType: idType ?? this.idType,
      idNumber: idNumber ?? this.idNumber,
    );
  }

  @override
  List<Object?> get props => [idType, idNumber];
}
