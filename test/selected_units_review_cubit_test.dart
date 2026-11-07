import 'package:flutter_hr_erb/features/owner_registration/data/model/owner_unit.dart';
import 'package:flutter_hr_erb/features/owner_registration/data/model/sample_units.dart';
import 'package:flutter_hr_erb/features/owner_registration/presentation/controller/selected_units_review_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  OwnerUnit unit(String id) => sampleUnits.firstWhere((unit) => unit.id == id);

  final units = [unit('unit-204'), unit('unit-305'), unit('chalet-16'), unit('villa-08')];
  late SelectedUnitsReviewCubit cubit;

  setUp(() => cubit = SelectedUnitsReviewCubit(units));

  tearDown(() => cubit.close());

  test('summarises units, distinct villages and distinct buildings', () {
    expect(cubit.state.unitCount, 4);
    expect(cubit.state.villageCount, 2);
    expect(cubit.state.buildingCount, 2);
    expect(cubit.state.canContinue, isTrue);
    expect(cubit.state.hasChanges, isFalse);
  });

  test('buildings with the same name in different villages are counted separately', () {
    const first = OwnerUnit(
      id: 'a',
      name: 'A',
      village: 'North',
      building: 'Building 1',
      location: '',
      type: UnitType.apartment,
      status: UnitStatus.eligible,
    );
    const second = OwnerUnit(
      id: 'b',
      name: 'B',
      village: 'South',
      building: 'Building 1',
      location: '',
      type: UnitType.apartment,
      status: UnitStatus.eligible,
    );
    final sameName = SelectedUnitsReviewCubit([first, second]);
    addTearDown(sameName.close);

    expect(sameName.state.buildingCount, 2);
  });

  test('remove drops the unit, updates the summary and marks changes', () {
    cubit.remove(unit('chalet-16'));

    expect(cubit.state.units.map((unit) => unit.id), ['unit-204', 'unit-305', 'villa-08']);
    expect(cubit.state.villageCount, 1);
    expect(cubit.state.buildingCount, 1);
    expect(cubit.state.hasChanges, isTrue);
  });

  test('removing a unit that is not in the list does nothing', () {
    cubit.remove(unit('cabin-06'));

    expect(cubit.state.unitCount, 4);
    expect(cubit.state.hasChanges, isFalse);
  });

  test('cannot continue once every unit is removed', () {
    for (final item in units) {
      cubit.remove(item);
    }

    expect(cubit.state.units, isEmpty);
    expect(cubit.state.canContinue, isFalse);
  });
}
