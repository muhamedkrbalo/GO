import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/verification_method.dart';

part 'verify_account_state.dart';

class VerifyAccountCubit extends Cubit<VerifyAccountState> {
  VerifyAccountCubit() : super(const VerifyAccountState());

  void selectMethod(VerificationMethod method) {
    if (state.isCodeSent) return;
    emit(state.copyWith(method: method));
  }

  void sendCode() {
    if (!state.canContinue) return;
    emit(state.copyWith(isCodeSent: true));
  }

  void resetCodeSent() => emit(state.copyWith(isCodeSent: false));
}
