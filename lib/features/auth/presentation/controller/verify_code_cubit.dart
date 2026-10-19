import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verify_code_state.dart';

class VerifyCodeCubit extends Cubit<VerifyCodeState> {
  VerifyCodeCubit() : super(const VerifyCodeState());

  static const codeLength = 6;
  static const resendCooldown = 60;

  Timer? _resendTimer;

  void codeChanged(String code) {
    if (code == state.code) return;
    emit(state.copyWith(code: code));
  }

  void resendCode() {
    if (!state.canResend) return;
    emit(state.copyWith(code: ''));
    startResendCooldown();
  }

  void startResendCooldown() {
    _resendTimer?.cancel();
    emit(state.copyWith(resendIn: resendCooldown));
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final remaining = state.resendIn - 1;
      if (remaining <= 0) timer.cancel();
      emit(state.copyWith(resendIn: remaining));
    });
  }

  @override
  Future<void> close() {
    _resendTimer?.cancel();
    return super.close();
  }
}
