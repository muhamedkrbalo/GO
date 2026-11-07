import 'package:flutter_hr_erb/features/owner_registration/data/model/ownership_type.dart';
import 'package:flutter_hr_erb/features/owner_registration/data/model/sample_units.dart';
import 'package:flutter_hr_erb/features/owner_registration/data/model/unit_details_status.dart';
import 'package:flutter_hr_erb/features/owner_registration/presentation/controller/ownership_details_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final units = [sampleUnits[0], sampleUnits[3], sampleUnits[5]];
  late OwnershipDetailsCubit cubit;

  String idAt(int index) => units[index].id;

  setUp(() => cubit = OwnershipDetailsCubit(units));

  tearDown(() => cubit.close());

  test('starts on the first unit with nothing started', () {
    expect(cubit.state.activeUnit, units[0]);
    expect(cubit.state.statusOf(idAt(0)), UnitDetailsStatus.notStarted);
    expect(cubit.state.canSaveActive, isFalse);
    expect(cubit.state.isComplete, isFalse);
  });

  test('selectUnit switches the active unit and ignores out of range indexes', () {
    cubit.selectUnit(2);
    expect(cubit.state.activeIndex, 2);

    cubit
      ..selectUnit(-1)
      ..selectUnit(units.length);
    expect(cubit.state.activeIndex, 2);
  });

  test('any entered value marks the unit in progress, and details stay per unit', () {
    cubit.setDocumentNumber(idAt(0), 'DOC-1');

    expect(cubit.state.statusOf(idAt(0)), UnitDetailsStatus.inProgress);
    expect(cubit.state.statusOf(idAt(1)), UnitDetailsStatus.notStarted);
    expect(cubit.state.detailsOf(idAt(1)).documentNumber, isEmpty);
  });

  test('save does nothing until ownership type is set', () {
    cubit
      ..setDate(idAt(0), DateTime(2020))
      ..saveActiveUnit();
    expect(cubit.state.statusOf(idAt(0)), UnitDetailsStatus.inProgress);

    cubit
      ..setType(idAt(0), OwnershipType.sole)
      ..saveActiveUnit();
    expect(cubit.state.statusOf(idAt(0)), UnitDetailsStatus.completed);
  });

  test('editing a saved unit moves it back to in progress', () {
    cubit
      ..setType(idAt(0), OwnershipType.sole)
      ..saveActiveUnit()
      ..setNotes(idAt(0), 'Updated');

    expect(cubit.state.statusOf(idAt(0)), UnitDetailsStatus.inProgress);
  });

  test('setting the same value again keeps a saved unit completed', () {
    cubit
      ..setType(idAt(0), OwnershipType.joint)
      ..saveActiveUnit()
      ..setType(idAt(0), OwnershipType.joint);

    expect(cubit.state.statusOf(idAt(0)), UnitDetailsStatus.completed);
  });

  test('continue is blocked while the active unit is invalid', () {
    cubit.continueToNextUnit();

    expect(cubit.state.activeIndex, 0);
    expect(cubit.state.savedIds, isEmpty);
  });

  test('continue saves and jumps to the next unsaved unit, wrapping around', () {
    cubit
      ..selectUnit(1)
      ..setType(idAt(1), OwnershipType.sole)
      ..continueToNextUnit();
    expect(cubit.state.activeIndex, 2);

    cubit
      ..setType(idAt(2), OwnershipType.inherited)
      ..continueToNextUnit();
    expect(cubit.state.activeIndex, 0);
    expect(cubit.state.isLastPendingUnit, isTrue);
  });

  test('the step is complete once every unit is saved', () {
    for (var index = 0; index < units.length; index++) {
      cubit.setType(idAt(index), OwnershipType.sole);
    }
    cubit
      ..continueToNextUnit()
      ..continueToNextUnit();
    expect(cubit.state.isComplete, isFalse);

    cubit.continueToNextUnit();
    expect(cubit.state.isComplete, isTrue);
    expect(cubit.state.completedCount, units.length);
  });
}
