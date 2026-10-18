import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/verify_code_args.dart';
import '../../data/repository/auth_repository.dart';

part 'verify_code_state.dart';

class VerifyCodeCubit extends Cubit<VerifyCodeState> {
  VerifyCodeCubit(this._repository, this.args) : super(const VerifyCodeState());

  static const codeLength = 6;
  static const maxAttempts = 5;
  static const resendCooldown = 60;

  final AuthRepository _repository;
  final VerifyCodeArgs args;
  Timer? _resendTimer;

  Future<void> sendCode() async {
    _startResendCooldown();
    final result = await _repository.sendVerificationCode(args);
    if (isClosed) return;
    result.fold(
      (failure) =>
          emit(state.copyWith(status: VerifyCodeStatus.failure, errorMessage: failure.errMessage)),
      (_) => emit(state.copyWith(status: VerifyCodeStatus.initial)),
    );
  }

  void codeChanged(String code) {
    if (code == state.code) return;
    final clearsError = state.hasError && code.isNotEmpty;
    emit(
      state.copyWith(
        code: code,
        status: clearsError ? VerifyCodeStatus.initial : null,
        errorMessage: clearsError ? null : state.errorMessage,
      ),
    );
  }

  Future<void> verify() async {
    if (!state.canVerify) return;
    emit(state.copyWith(status: VerifyCodeStatus.verifying));
    final result = await _repository.verifyCode(args, state.code);
    if (isClosed) return;
    result.fold(
      (_) => emit(
        state.copyWith(
          code: '',
          status: VerifyCodeStatus.invalid,
          attemptsRemaining: state.attemptsRemaining - 1,
        ),
      ),
      (_) => emit(state.copyWith(status: VerifyCodeStatus.verified)),
    );
  }

  Future<void> resendCode() async {
    if (!state.canResend) return;
    emit(
      state.copyWith(code: '', status: VerifyCodeStatus.initial, attemptsRemaining: maxAttempts),
    );
    await sendCode();
  }

  void _startResendCooldown() {
    _resendTimer?.cancel();
    emit(state.copyWith(resendIn: resendCooldown, errorMessage: state.errorMessage));
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final remaining = state.resendIn - 1;
      if (remaining <= 0) timer.cancel();
      emit(state.copyWith(resendIn: remaining, errorMessage: state.errorMessage));
    });
  }

  @override
  Future<void> close() {
    _resendTimer?.cancel();
    return super.close();
  }
}
