import 'package:equatable/equatable.dart';

import '../../../../core/locale/app_locale_key.dart';
import 'broker_village.dart';

enum BrokerVillageAssignmentStatus {
  pendingEndorsement(AppLocaleKey.pendingEndorsement),
  active(AppLocaleKey.active),
  rejected(AppLocaleKey.rejected),
  suspended(AppLocaleKey.suspended),
  expired(AppLocaleKey.expired);

  const BrokerVillageAssignmentStatus(this.labelKey);

  final String labelKey;
}

class BrokerVillageAssignment extends Equatable {
  const BrokerVillageAssignment({
    required this.village,
    required this.status,
    required this.endorsementCount,
    required this.requiredEndorsements,
    required this.lastUpdated,
  });

  factory BrokerVillageAssignment.requested(
    BrokerVillage village, {
    required DateTime submittedAt,
  }) {
    return BrokerVillageAssignment(
      village: village,
      status: BrokerVillageAssignmentStatus.pendingEndorsement,
      endorsementCount: 0,
      requiredEndorsements: defaultRequiredEndorsements,
      lastUpdated: submittedAt,
    );
  }

  static const defaultRequiredEndorsements = 3;

  final BrokerVillage village;
  final BrokerVillageAssignmentStatus status;
  final int endorsementCount;
  final int requiredEndorsements;
  final DateTime lastUpdated;

  @override
  List<Object?> get props => [village, status, endorsementCount, requiredEndorsements, lastUpdated];
}
