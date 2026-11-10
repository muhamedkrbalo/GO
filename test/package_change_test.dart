import 'package:flutter_hr_erb/features/owner_packages/data/model/owner_package.dart';
import 'package:flutter_hr_erb/features/owner_packages/data/model/package_change.dart';
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

void main() {
  final essential = _package('essential', 1200);
  final growth = _package('growth', 2400);

  test('additionalAmountDue is the price difference for an upgrade', () {
    expect(PackageChange(current: essential, target: growth).additionalAmountDue, 1200);
  });

  test('additionalAmountDue is zero for the same package', () {
    expect(PackageChange(current: essential, target: essential).additionalAmountDue, 0);
  });

  test('additionalAmountDue never goes negative for a cheaper target', () {
    expect(PackageChange(current: growth, target: essential).additionalAmountDue, 0);
  });
}
