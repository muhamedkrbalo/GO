import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/registration_receipt.dart';
import '../../data/model/unit_review.dart';

part 'registration_status_state.dart';

class RegistrationStatusCubit extends Cubit<RegistrationStatusState> {
  RegistrationStatusCubit({required RegistrationReceipt receipt, required List<UnitReview> reviews})
    : super(RegistrationStatusState(receipt: receipt, reviews: List.unmodifiable(reviews)));

  void selectFilter(ReviewFilter filter) {
    if (filter == state.filter) return;
    emit(state.copyWith(filter: filter));
  }
}
