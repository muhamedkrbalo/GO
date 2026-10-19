part of 'owner_documents_cubit.dart';

class OwnerDocumentsState extends Equatable {
  const OwnerDocumentsState({required this.units, this.documents = const {}});

  static const identitySlot = DocumentSlot(DocumentType.identity);
  static const supportingSlot = DocumentSlot(DocumentType.supporting);

  final List<OwnerUnit> units;
  final Map<DocumentSlot, UploadedDocument> documents;

  static DocumentSlot contractSlotOf(String unitId) {
    return DocumentSlot(DocumentType.ownershipContract, unitId: unitId);
  }

  UploadedDocument? documentOf(DocumentSlot slot) => documents[slot];

  bool isUnitComplete(String unitId) => documents.containsKey(contractSlotOf(unitId));

  bool get isComplete =>
      documents.containsKey(identitySlot) && units.every((unit) => isUnitComplete(unit.id));

  @override
  List<Object?> get props => [units, documents];
}
