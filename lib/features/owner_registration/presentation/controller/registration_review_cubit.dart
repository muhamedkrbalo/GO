import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/owner_document.dart';
import '../../data/model/owner_type.dart';
import '../../data/model/registration_receipt.dart';
import 'owner_registration_draft_cubit.dart';

part 'registration_review_state.dart';

class RegistrationReviewCubit extends Cubit<RegistrationReviewState> {
  RegistrationReviewCubit(OwnerRegistrationDraft draft, {DateTime Function()? clock})
    : _clock = clock ?? DateTime.now,
      super(RegistrationReviewState(draft: draft));

  final DateTime Function() _clock;

  void setConfirmed(bool isConfirmed) {
    if (isConfirmed == state.isConfirmed) return;
    emit(state.copyWith(isConfirmed: isConfirmed));
  }

  void submit() {
    if (state.receipt != null) return;
    emit(
      state.copyWith(
        receipt: RegistrationReceipt.issue(
          submittedAt: _clock(),
          units: state.draft.units,
          ownershipTypes: {
            for (final entry in state.draft.ownership.entries) entry.key: ?entry.value.type,
          },
        ),
      ),
    );
  }
}
