import 'package:flutter_hr_erb/features/owner_registration/data/model/ownership_type.dart';
import 'package:flutter_hr_erb/features/owner_registration/data/model/sample_units.dart';
import 'package:flutter_hr_erb/features/owner_registration/presentation/controller/ownership_details_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final units = [sampleUnits[0], sampleUnits[5]];
  late OwnershipDetailsCubit cubit;

  setUp(() => cubit = OwnershipDetailsCubit(units));

  tearDown(() => cubit.close());

  test('starts with nothing complete', () {
    expect(cubit.state.completedCount, 0);
    expect(cubit.state.isComplete, isFalse);
  });

  test('a unit is complete only once it has both a type and a date', () {
    cubit.setType(units[0].id, OwnershipType.sole);
    expect(cubit.state.detailsOf(units[0].id).isComplete, isFalse);

    cubit.setDate(units[0].id, DateTime(2020, 5, 2));
    expect(cubit.state.detailsOf(units[0].id).isComplete, isTrue);
    expect(cubit.state.completedCount, 1);
    expect(cubit.state.isComplete, isFalse);
  });

  test('details are kept separately per unit', () {
    cubit
      ..setType(units[0].id, OwnershipType.joint)
      ..setType(units[1].id, OwnershipType.inherited);
    expect(cubit.state.detailsOf(units[0].id).type, OwnershipType.joint);
    expect(cubit.state.detailsOf(units[1].id).type, OwnershipType.inherited);
  });

  test('the step is complete when every unit is complete', () {
    for (final unit in units) {
      cubit
        ..setType(unit.id, OwnershipType.sole)
        ..setDate(unit.id, DateTime(2021));
    }
    expect(cubit.state.isComplete, isTrue);
  });
}
