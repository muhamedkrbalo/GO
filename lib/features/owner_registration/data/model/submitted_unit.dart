import 'package:equatable/equatable.dart';

import 'owner_document.dart';
import 'owner_unit.dart';
import 'ownership_type.dart';

class SubmittedUnit extends Equatable {
  const SubmittedUnit({
    required this.unit,
    this.ownershipType,
    this.ownershipDate,
    this.documentNumber = '',
    this.documents = const [],
  });

  final OwnerUnit unit;
  final OwnershipType? ownershipType;
  final DateTime? ownershipDate;
  final String documentNumber;
  final List<UploadedDocument> documents;

  @override
  List<Object?> get props => [unit, ownershipType, ownershipDate, documentNumber, documents];
}
