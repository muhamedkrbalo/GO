import 'package:equatable/equatable.dart';

import 'submitted_unit.dart';

class RegistrationReceipt extends Equatable {
  const RegistrationReceipt({
    required this.referenceNumber,
    required this.submittedAt,
    required this.units,
  });

  factory RegistrationReceipt.issue({
    required DateTime submittedAt,
    required List<SubmittedUnit> units,
  }) {
    return RegistrationReceipt(
      referenceNumber: '$_referencePrefix${submittedAt.millisecondsSinceEpoch}',
      submittedAt: submittedAt,
      units: List.unmodifiable(units),
    );
  }

  static const _referencePrefix = 'GO-OWNER-';

  final String referenceNumber;
  final DateTime submittedAt;
  final List<SubmittedUnit> units;

  int get unitCount => units.length;

  @override
  List<Object?> get props => [referenceNumber, submittedAt, units];
}
