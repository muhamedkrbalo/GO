part of 'broker_personal_info_cubit.dart';

class BrokerPersonalInfoState extends Equatable {
  const BrokerPersonalInfoState({
    required this.phoneCountry,
    this.fullName = '',
    this.nationality,
    this.mobileNumber = '',
    this.email = '',
  });

  final String fullName;
  final Country? nationality;
  final Country phoneCountry;
  final String mobileNumber;
  final String email;

  bool get canContinue =>
      fullName.trim().isNotEmpty &&
      nationality != null &&
      mobileNumber.trim().isNotEmpty &&
      email.trim().isNotEmpty;

  BrokerPersonalInfoState copyWith({
    String? fullName,
    Country? nationality,
    Country? phoneCountry,
    String? mobileNumber,
    String? email,
  }) {
    return BrokerPersonalInfoState(
      fullName: fullName ?? this.fullName,
      nationality: nationality ?? this.nationality,
      phoneCountry: phoneCountry ?? this.phoneCountry,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [
    fullName,
    nationality?.countryCode,
    phoneCountry.countryCode,
    mobileNumber,
    email,
  ];
}
