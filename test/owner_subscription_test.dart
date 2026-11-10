import 'package:flutter_hr_erb/features/auth/data/model/business_role.dart';
import 'package:flutter_hr_erb/features/owner_packages/data/model/owner_package.dart';
import 'package:flutter_hr_erb/features/owner_packages/data/model/owner_subscription.dart';
import 'package:flutter_test/flutter_test.dart';

OwnerPackage _package(String id, double price) => OwnerPackage(
  id: id,
  name: id,
  price: price,
  durationMonths: 12,
  features: const [],
  unitsLimit: 1,
  businessUsersLimit: 1,
);

OwnerSubscription _subscriptionOn(OwnerPackage package) => OwnerSubscription(
  package: package,
  packageType: BusinessRole.owner,
  status: SubscriptionStatus.active,
  startDate: DateTime(2026),
  endDate: DateTime(2027),
  renewalDate: DateTime(2027),
  coveredRelationships: const [BusinessRole.owner],
);

void main() {
  final basic = _package('basic', 600);
  final essential = _package('essential', 1200);
  final growth = _package('growth', 2400);
  final premium = _package('premium', 4800);
  final catalog = [basic, essential, growth, premium];

  test('upgradeOptions returns only higher-priced packages in catalog order', () {
    expect(_subscriptionOn(essential).upgradeOptions(catalog), [growth, premium]);
  });

  test('upgradeOptions excludes the current package and equal prices', () {
    final samePrice = _package('essential-plus', 1200);

    expect(_subscriptionOn(essential).upgradeOptions([...catalog, samePrice]), [growth, premium]);
  });

  test('upgradeOptions is empty on the highest package', () {
    expect(_subscriptionOn(premium).upgradeOptions(catalog), isEmpty);
  });
}
