import 'package:flutter_hr_erb/features/owner_registration/data/model/owner_unit.dart';
import 'package:flutter_hr_erb/features/owner_registration/data/model/sample_units.dart';
import 'package:flutter_hr_erb/features/owner_registration/presentation/controller/unit_selection_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late UnitSelectionCubit cubit;

  OwnerUnit unit(String id) => sampleUnits.firstWhere((unit) => unit.id == id);

  setUp(() => cubit = UnitSelectionCubit(sampleUnits));

  tearDown(() => cubit.close());

  test('shows every unit at first', () {
    expect(cubit.state.visibleUnits, sampleUnits);
    expect(cubit.state.selectedCount, 0);
  });

  test('search matches name and location, ignoring case', () {
    cubit.search('villa');
    expect(cubit.state.visibleUnits.map((unit) => unit.id), ['villa-08', 'villa-31']);

    cubit.search('BLANCA');
    expect(cubit.state.visibleUnits.map((unit) => unit.id), ['unit-204', 'unit-305']);
  });

  test('filters combine and null clears a filter', () {
    cubit
      ..setVillage('Amwaj')
      ..setUnitType(UnitType.chalet);
    expect(cubit.state.visibleUnits.map((unit) => unit.id), ['chalet-11']);

    cubit.setUnitType(null);
    expect(cubit.state.visibleUnits.map((unit) => unit.id), ['unit-102', 'chalet-11']);
  });

  test('changing village drops a building that is not in it', () {
    cubit
      ..setBuilding('Building 12')
      ..setVillage('Gouna');
    expect(cubit.state.building, isNull);
    expect(cubit.state.visibleUnits.map((unit) => unit.id), ['cabin-06']);
  });

  test('only eligible units can be selected, and tapping again unselects', () {
    cubit.toggleUnit(unit('villa-08'));
    expect(cubit.state.selectedCount, 0);

    cubit.toggleUnit(unit('unit-204'));
    expect(cubit.state.selectedIds, {'unit-204'});

    cubit.toggleUnit(unit('unit-204'));
    expect(cubit.state.selectedIds, isEmpty);
  });

  test('view selected shows only selected units and turns off when nothing is selected', () {
    cubit
      ..toggleUnit(unit('unit-204'))
      ..toggleUnit(unit('cabin-06'))
      ..toggleShowSelectedOnly();
    expect(cubit.state.visibleUnits.map((unit) => unit.id), ['unit-204', 'cabin-06']);

    cubit
      ..toggleUnit(unit('unit-204'))
      ..toggleUnit(unit('cabin-06'));
    expect(cubit.state.showSelectedOnly, isFalse);
    expect(cubit.state.visibleUnits, sampleUnits);
  });
}
