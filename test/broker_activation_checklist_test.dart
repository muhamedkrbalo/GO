import 'package:flutter_hr_erb/features/broker_registration/data/model/broker_activation_checklist.dart';
import 'package:flutter_hr_erb/features/broker_registration/data/model/broker_village.dart';
import 'package:flutter_hr_erb/features/broker_registration/data/model/broker_village_assignment.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const village = BrokerVillage(
    id: 'green-valley',
    name: 'Green Valley',
    area: 'New Cairo',
    governorate: 'Cairo',
    status: BrokerVillageStatus.available,
  );
  final updatedAt = DateTime(2026, 11, 3);

  BrokerVillageAssignment assignment({
    required BrokerVillageAssignmentStatus status,
    required int endorsements,
  }) {
    return BrokerVillageAssignment(
      village: village,
      status: status,
      endorsementCount: endorsements,
      requiredEndorsements: 3,
      lastUpdated: updatedAt,
    );
  }

  test('freshly requested villages only complete registration approval', () {
    final checklist = BrokerActivationChecklist.fromAssignments([
      BrokerVillageAssignment.requested(village, submittedAt: updatedAt),
    ]);

    expect(checklist.completed, {BrokerActivationRequirement.registrationApproved});
    expect(checklist.isActive, isFalse);
  });

  test('active, fully endorsed villages complete their requirements', () {
    final checklist = BrokerActivationChecklist.fromAssignments([
      assignment(status: BrokerVillageAssignmentStatus.active, endorsements: 3),
    ]);

    expect(checklist.isComplete(BrokerActivationRequirement.villageAssignmentsApproved), isTrue);
    expect(checklist.isComplete(BrokerActivationRequirement.ownerEndorsementsCompleted), isTrue);
    expect(checklist.isActive, isFalse);
  });

  test('one pending village keeps both village requirements incomplete', () {
    final checklist = BrokerActivationChecklist.fromAssignments([
      assignment(status: BrokerVillageAssignmentStatus.active, endorsements: 3),
      assignment(status: BrokerVillageAssignmentStatus.pendingEndorsement, endorsements: 1),
    ]);

    expect(checklist.isComplete(BrokerActivationRequirement.villageAssignmentsApproved), isFalse);
    expect(checklist.isComplete(BrokerActivationRequirement.ownerEndorsementsCompleted), isFalse);
  });

  test('no assignments never counts as approved villages', () {
    final checklist = BrokerActivationChecklist.fromAssignments(const []);

    expect(checklist.isComplete(BrokerActivationRequirement.villageAssignmentsApproved), isFalse);
    expect(checklist.isComplete(BrokerActivationRequirement.ownerEndorsementsCompleted), isFalse);
  });

  test('is active only when every requirement is complete', () {
    const checklist = BrokerActivationChecklist(completed: {...BrokerActivationRequirement.values});

    expect(checklist.isActive, isTrue);
  });
}
