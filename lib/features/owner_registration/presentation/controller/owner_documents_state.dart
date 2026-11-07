part of 'owner_documents_cubit.dart';

class OwnerDocumentsState extends Equatable {
  const OwnerDocumentsState({required this.units, this.documents = const {}});

  final List<OwnerUnit> units;
  final Map<DocumentSlot, UploadedDocument> documents;

  UploadedDocument? documentOf(DocumentSlot slot) => documents[slot];

  bool _has(DocumentType type, {String? unitId}) {
    return documents.containsKey(DocumentSlot(type, unitId: unitId));
  }

  int get ownerUploadedCount => DocumentType.ownerTypes.where(_has).length;

  int get ownerTotal => DocumentType.ownerTypes.length;

  int uploadedCountOf(String unitId) {
    return DocumentType.unitTypes.where((type) => _has(type, unitId: unitId)).length;
  }

  int get unitUploadedCount => units.fold(0, (sum, unit) => sum + uploadedCountOf(unit.id));

  int get unitTotal => units.length * DocumentType.unitTypes.length;

  bool isUnitComplete(String unitId) {
    return DocumentType.unitTypes
        .where((type) => type.isRequired)
        .every((type) => _has(type, unitId: unitId));
  }

  bool get isOwnerComplete => DocumentType.ownerTypes.where((type) => type.isRequired).every(_has);

  bool get isComplete => isOwnerComplete && units.every((unit) => isUnitComplete(unit.id));

  @override
  List<Object?> get props => [units, documents];
}
