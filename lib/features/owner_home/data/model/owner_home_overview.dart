import 'package:equatable/equatable.dart';

class OwnerHomeOverview extends Equatable {
  const OwnerHomeOverview({
    this.referenceNumber,
    this.submittedAt,
    this.totalUnits = 0,
    this.actionRequired = 0,
    this.hasActiveSubscription = false,
  });

  static const empty = OwnerHomeOverview();

  final String? referenceNumber;
  final DateTime? submittedAt;
  final int totalUnits;
  final int actionRequired;
  final bool hasActiveSubscription;

  bool get isSubmitted => referenceNumber != null;

  bool get hasRequiredCorrections => actionRequired > 0;

  @override
  List<Object?> get props => [
    referenceNumber,
    submittedAt,
    totalUnits,
    actionRequired,
    hasActiveSubscription,
  ];
}
