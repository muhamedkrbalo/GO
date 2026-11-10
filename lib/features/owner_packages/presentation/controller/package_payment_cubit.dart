import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/uploaded_document.dart';
import '../../data/model/payment_method.dart';

part 'package_payment_state.dart';

class PackagePaymentCubit extends Cubit<PackagePaymentState> {
  PackagePaymentCubit() : super(const PackagePaymentState());

  void selectMethod(PaymentMethod method) {
    if (method == state.method) return;
    emit(state.copyWith(method: method));
  }

  void updateReference(String reference) {
    if (reference == state.reference) return;
    emit(state.copyWith(reference: reference));
  }

  void attachProof(UploadedDocument proof) => emit(state.copyWith(proof: proof));

  void removeProof() {
    if (state.proof == null) return;
    emit(state.copyWith(clearProof: true));
  }
}
