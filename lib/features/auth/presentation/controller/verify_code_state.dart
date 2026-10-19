part of 'verify_code_cubit.dart';

class VerifyCodeState extends Equatable {
  const VerifyCodeState({this.code = '', this.resendIn = 0});

  final String code;
  final int resendIn;

  bool get canVerify => code.length == VerifyCodeCubit.codeLength;

  bool get canResend => resendIn == 0;

  VerifyCodeState copyWith({String? code, int? resendIn}) {
    return VerifyCodeState(code: code ?? this.code, resendIn: resendIn ?? this.resendIn);
  }

  @override
  List<Object?> get props => [code, resendIn];
}
