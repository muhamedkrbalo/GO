import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/owner_document.dart';
import '../../data/model/owner_type.dart';
import 'owner_registration_draft_cubit.dart';

part 'registration_review_state.dart';

class RegistrationReviewCubit extends Cubit<RegistrationReviewState> {
  RegistrationReviewCubit(OwnerRegistrationDraft draft)
    : super(RegistrationReviewState(draft: draft));

  void setConfirmed(bool isConfirmed) {
    if (isConfirmed == state.isConfirmed) return;
    emit(state.copyWith(isConfirmed: isConfirmed));
  }
}
