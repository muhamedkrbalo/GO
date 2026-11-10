import '../../../auth/data/model/business_role.dart';
import 'owner_subscription.dart';
import 'sample_owner_packages.dart';

final sampleOwnerSubscription = OwnerSubscription(
  package: sampleOwnerPackages.first,
  packageType: BusinessRole.owner,
  status: SubscriptionStatus.cancelled,
  startDate: DateTime(2026, 11, 3),
  endDate: DateTime(2027, 11, 3),
  renewalDate: DateTime(2027, 11, 3),
  coveredRelationships: const [BusinessRole.owner],
  previousPackageName: sampleOwnerPackages.first.name,
);
