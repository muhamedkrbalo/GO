import 'package:equatable/equatable.dart';

import 'owner_unit.dart';
import 'ownership_type.dart';

class RegistrationReceipt extends Equatable {
  const RegistrationReceipt({
    required this.referenceNumber,
    required this.submittedAt,
    required this.units,
    this.ownershipTypes = const {},
  });

  factory RegistrationReceipt.issue({
    required DateTime submittedAt,
    required List<OwnerUnit> units,
    Map<String, OwnershipType> ownershipTypes = const {},
  }) {
    return RegistrationReceipt(
      referenceNumber: '$_referencePrefix${submittedAt.millisecondsSinceEpoch}',
      submittedAt: submittedAt,
      units: List.unmodifiable(units),
      ownershipTypes: Map.unmodifiable(ownershipTypes),
    );
  }

  static const _referencePrefix = 'GO-OWNER-';

  final String referenceNumber;
  final DateTime submittedAt;
  final List<OwnerUnit> units;
  final Map<String, OwnershipType> ownershipTypes;

  int get unitCount => units.length;

  @override
  List<Object?> get props => [referenceNumber, submittedAt, units, ownershipTypes];
}
