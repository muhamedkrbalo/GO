part of 'verify_account_cubit.dart';

class VerifyAccountState extends Equatable {
  const VerifyAccountState({this.method, this.isCodeSent = false});

  final VerificationMethod? method;
  final bool isCodeSent;

  bool get canContinue => method != null && !isCodeSent;

  VerifyAccountState copyWith({VerificationMethod? method, bool? isCodeSent}) {
    return VerifyAccountState(
      method: method ?? this.method,
      isCodeSent: isCodeSent ?? this.isCodeSent,
    );
  }

  @override
  List<Object?> get props => [method, isCodeSent];
}
