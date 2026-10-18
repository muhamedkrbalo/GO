part of 'verify_code_cubit.dart';

enum VerifyCodeStatus { initial, verifying, invalid, verified, failure }

class VerifyCodeState extends Equatable {
  const VerifyCodeState({
    this.code = '',
    this.status = VerifyCodeStatus.initial,
    this.attemptsRemaining = VerifyCodeCubit.maxAttempts,
    this.resendIn = 0,
    this.errorMessage,
  });

  final String code;
  final VerifyCodeStatus status;
  final int attemptsRemaining;
  final int resendIn;
  final String? errorMessage;

  bool get isLocked => attemptsRemaining == 0;

  bool get hasError => status == VerifyCodeStatus.invalid || status == VerifyCodeStatus.failure;

  bool get canVerify =>
      code.length == VerifyCodeCubit.codeLength &&
      !isLocked &&
      status != VerifyCodeStatus.verifying &&
      status != VerifyCodeStatus.verified;

  bool get canResend => resendIn == 0 && status != VerifyCodeStatus.verifying;

  VerifyCodeState copyWith({
    String? code,
    VerifyCodeStatus? status,
    int? attemptsRemaining,
    int? resendIn,
    String? errorMessage,
  }) {
    return VerifyCodeState(
      code: code ?? this.code,
      status: status ?? this.status,
      attemptsRemaining: attemptsRemaining ?? this.attemptsRemaining,
      resendIn: resendIn ?? this.resendIn,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [code, status, attemptsRemaining, resendIn, errorMessage];
}
