part of 'verify_code_cubit.dart';

class VerifyCodeState extends Equatable {
  const VerifyCodeState({
    this.code = '',
    this.resendIn = 0,
    this.expiresIn = VerifyCodeCubit.codeLifetime,
  });

  final String code;
  final int resendIn;
  final int expiresIn;

  bool get isExpired => expiresIn == 0;

  bool get canVerify => code.length == VerifyCodeCubit.codeLength && !isExpired;

  bool get canResend => resendIn == 0;

  VerifyCodeState copyWith({String? code, int? resendIn, int? expiresIn}) {
    return VerifyCodeState(
      code: code ?? this.code,
      resendIn: resendIn ?? this.resendIn,
      expiresIn: expiresIn ?? this.expiresIn,
    );
  }

  @override
  List<Object?> get props => [code, resendIn, expiresIn];
}
