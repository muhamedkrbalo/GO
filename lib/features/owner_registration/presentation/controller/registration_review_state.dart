part of 'registration_review_cubit.dart';

class RegistrationReviewState extends Equatable {
  const RegistrationReviewState({required this.draft, this.isConfirmed = false, this.receipt});

  final OwnerRegistrationDraft draft;
  final bool isConfirmed;
  final RegistrationReceipt? receipt;

  bool get isOwnerInfoComplete {
    final ownerComplete = switch (draft.ownerType) {
      OwnerType.individual => draft.individual?.canContinue ?? false,
      OwnerType.company => draft.company?.canContinue ?? false,
      null => false,
    };
    return ownerComplete && (draft.address?.canContinue ?? false);
  }

  bool get areRequiredDocumentsUploaded {
    final ownerDocuments = DocumentType.ownerTypes
        .where((type) => type.isRequired)
        .every((type) => draft.documents.containsKey(DocumentSlot(type)));
    final unitDocuments = draft.units.every(
      (unit) => DocumentType.unitTypes
          .where((type) => type.isRequired)
          .every((type) => draft.documents.containsKey(DocumentSlot(type, unitId: unit.id))),
    );
    return ownerDocuments && unitDocuments;
  }

  bool isUnitInfoComplete(String unitId) => draft.ownership[unitId]?.isValid ?? false;

  bool get allUnitsHaveOwnership =>
      draft.units.isNotEmpty && draft.units.every((unit) => isUnitInfoComplete(unit.id));

  bool get isReadyToSubmit =>
      isOwnerInfoComplete && areRequiredDocumentsUploaded && allUnitsHaveOwnership;

  bool get canSubmit => isReadyToSubmit && isConfirmed;

  RegistrationReviewState copyWith({bool? isConfirmed, RegistrationReceipt? receipt}) {
    return RegistrationReviewState(
      draft: draft,
      isConfirmed: isConfirmed ?? this.isConfirmed,
      receipt: receipt ?? this.receipt,
    );
  }

  @override
  List<Object?> get props => [draft, isConfirmed, receipt];
}
