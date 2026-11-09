import 'package:equatable/equatable.dart';

import '../../../../core/locale/app_locale_key.dart';
import 'broker_village_assignment.dart';

enum BrokerActivationRequirement {
  registrationApproved(AppLocaleKey.brokerRegistrationApproved),
  businessRelationshipApproved(AppLocaleKey.businessRelationshipApproved),
  villageAssignmentsApproved(AppLocaleKey.requiredVillageAssignmentsApproved),
  ownerEndorsementsCompleted(AppLocaleKey.requiredOwnerEndorsementsCompleted),
  subscriptionActive(AppLocaleKey.subscriptionActive),
  permissionsAvailable(AppLocaleKey.requiredPermissionsAvailable);

  const BrokerActivationRequirement(this.labelKey);

  final String labelKey;
}

class BrokerActivationChecklist extends Equatable {
  const BrokerActivationChecklist({required this.completed});

  factory BrokerActivationChecklist.fromAssignments(List<BrokerVillageAssignment> assignments) {
    final hasAssignments = assignments.isNotEmpty;
    return BrokerActivationChecklist(
      completed: {
        BrokerActivationRequirement.registrationApproved,
        if (hasAssignments &&
            assignments.every(
              (assignment) => assignment.status == BrokerVillageAssignmentStatus.active,
            ))
          BrokerActivationRequirement.villageAssignmentsApproved,
        if (hasAssignments && assignments.every((assignment) => assignment.isEndorsementComplete))
          BrokerActivationRequirement.ownerEndorsementsCompleted,
      },
    );
  }

  final Set<BrokerActivationRequirement> completed;

  bool isComplete(BrokerActivationRequirement requirement) => completed.contains(requirement);

  bool get isActive => BrokerActivationRequirement.values.every(completed.contains);

  @override
  List<Object?> get props => [completed];
}
