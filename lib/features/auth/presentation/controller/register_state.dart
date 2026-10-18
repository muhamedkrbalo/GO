part of 'register_cubit.dart';

class RegisterState extends Equatable {
  const RegisterState({required this.country, });


  final Country country;

  RegisterState copyWith({Country? country, int? step, }) {
    return RegisterState(
      country: country ?? this.country,
    );
  }

  @override
  List<Object?> get props => [country, ];
}
