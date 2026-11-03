import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verify_code_state.dart';

class VerifyCodeCubit extends Cubit<VerifyCodeState> {
  VerifyCodeCubit() : super(const VerifyCodeState());

  static const codeLength = 6;
  static const resendCooldown = 60;
  static const codeLifetime = 300;

  Timer? _countdownTimer;

  void codeChanged(String code) {
    if (code == state.code) return;
    emit(state.copyWith(code: code));
  }

  void resendCode() {
    if (!state.canResend) return;
    emit(state.copyWith(code: ''));
    startCountdown();
  }

  void startCountdown() {
    _countdownTimer?.cancel();
    emit(state.copyWith(resendIn: resendCooldown, expiresIn: codeLifetime));
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final resendIn = state.resendIn > 0 ? state.resendIn - 1 : 0;
      final expiresIn = state.expiresIn > 0 ? state.expiresIn - 1 : 0;
      if (resendIn == 0 && expiresIn == 0) timer.cancel();
      emit(state.copyWith(resendIn: resendIn, expiresIn: expiresIn));
    });
  }

  @override
  Future<void> close() {
    _countdownTimer?.cancel();
    return super.close();
  }
}
