import 'package:flutter_hr_erb/features/owner_packages/data/model/owner_package.dart';
import 'package:flutter_hr_erb/features/owner_packages/presentation/controller/owner_packages_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

const _essential = OwnerPackage(
  id: 'essential',
  name: 'Essential',
  price: 1200,
  durationMonths: 12,
  features: ['Workspace'],
  unitsLimit: 5,
  businessUsersLimit: 2,
);

const _growth = OwnerPackage(
  id: 'growth',
  name: 'Growth',
  price: 2400,
  durationMonths: 12,
  features: ['Workspace', 'More units'],
  unitsLimit: 15,
  businessUsersLimit: 5,
);

void main() {
  late OwnerPackagesCubit cubit;

  setUp(() => cubit = OwnerPackagesCubit(const [_essential, _growth]));

  tearDown(() => cubit.close());

  test('starts with the packages and nothing selected', () {
    expect(cubit.state.packages, [_essential, _growth]);
    expect(cubit.state.selectedPackage, isNull);
    expect(cubit.state.canContinue, isFalse);
  });

  test('selectPackage selects the package and enables continue', () {
    cubit.selectPackage(_growth.id);

    expect(cubit.state.selectedPackage, _growth);
    expect(cubit.state.isSelected(_growth.id), isTrue);
    expect(cubit.state.isSelected(_essential.id), isFalse);
    expect(cubit.state.canContinue, isTrue);
  });

  test('selecting another package replaces the previous selection', () {
    cubit
      ..selectPackage(_essential.id)
      ..selectPackage(_growth.id);

    expect(cubit.state.selectedPackage, _growth);
  });

  test('selecting the already selected package emits nothing', () async {
    cubit.selectPackage(_essential.id);
    final emitted = <OwnerPackagesState>[];
    final subscription = cubit.stream.listen(emitted.add);

    cubit.selectPackage(_essential.id);
    await Future<void>.delayed(Duration.zero);

    expect(emitted, isEmpty);
    await subscription.cancel();
  });

  test('selecting an unknown package id is ignored', () {
    cubit.selectPackage('missing');

    expect(cubit.state.selectedId, isNull);
    expect(cubit.state.canContinue, isFalse);
  });
}
