import 'package:equatable/equatable.dart';

class RegistrationReceipt extends Equatable {
  const RegistrationReceipt({
    required this.referenceNumber,
    required this.submittedAt,
    required this.unitCount,
  });

  factory RegistrationReceipt.issue({required DateTime submittedAt, required int unitCount}) {
    return RegistrationReceipt(
      referenceNumber: '$_referencePrefix${submittedAt.millisecondsSinceEpoch}',
      submittedAt: submittedAt,
      unitCount: unitCount,
    );
  }

  static const _referencePrefix = 'GO-OWNER-';

  final String referenceNumber;
  final DateTime submittedAt;
  final int unitCount;

  @override
  List<Object?> get props => [referenceNumber, submittedAt, unitCount];
}
