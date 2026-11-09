import 'package:flutter_hr_erb/features/broker_registration/data/model/broker_village.dart';
import 'package:flutter_hr_erb/features/broker_registration/presentation/controller/broker_village_selection_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const greenValley = BrokerVillage(
    id: 'green-valley',
    name: 'Green Valley',
    area: 'New Cairo',
    governorate: 'Cairo',
    status: BrokerVillageStatus.available,
  );
  const palmVillage = BrokerVillage(
    id: 'palm-village',
    name: 'Palm Village',
    area: '6th of October',
    governorate: 'Giza',
    status: BrokerVillageStatus.available,
  );
  const gardenVillage = BrokerVillage(
    id: 'garden-village',
    name: 'Garden Village',
    area: 'Sheikh Zayed',
    governorate: 'Giza',
    status: BrokerVillageStatus.available,
  );
  const marinaVillage = BrokerVillage(
    id: 'marina-village',
    name: 'Marina Village',
    area: 'North Coast',
    governorate: 'Matrouh',
    status: BrokerVillageStatus.unavailable,
  );
  const sunsetResidence = BrokerVillage(
    id: 'sunset-residence',
    name: 'Sunset Residence',
    area: 'New Cairo',
    governorate: 'Cairo',
    status: BrokerVillageStatus.alreadyAssigned,
  );
  const villages = [greenValley, palmVillage, gardenVillage, marinaVillage, sunsetResidence];

  late BrokerVillageSelectionCubit cubit;

  setUp(() => cubit = BrokerVillageSelectionCubit(villages, maxSelection: 2));

  tearDown(() => cubit.close());

  test('starts with every village visible and nothing selected', () {
    expect(cubit.state.visibleVillages, villages);
    expect(cubit.state.selectedCount, 0);
    expect(cubit.state.canSubmit, isFalse);
    expect(cubit.state.areas, ['New Cairo', '6th of October', 'Sheikh Zayed', 'North Coast']);
  });

  test('toggling an available village selects then deselects it', () {
    cubit.toggleVillage(greenValley);
    expect(cubit.state.isSelected(greenValley), isTrue);
    expect(cubit.state.canSubmit, isTrue);

    cubit.toggleVillage(greenValley);
    expect(cubit.state.isSelected(greenValley), isFalse);
    expect(cubit.state.canSubmit, isFalse);
  });

  test('unavailable and already assigned villages cannot be selected', () {
    cubit
      ..toggleVillage(marinaVillage)
      ..toggleVillage(sunsetResidence);

    expect(cubit.state.selectedIds, isEmpty);
  });

  test('stops selecting at the limit but still allows deselecting', () {
    cubit
      ..toggleVillage(greenValley)
      ..toggleVillage(palmVillage)
      ..toggleVillage(gardenVillage);

    expect(cubit.state.selectedIds, {greenValley.id, palmVillage.id});
    expect(cubit.state.isLimitReached, isTrue);
    expect(cubit.state.canToggle(gardenVillage), isFalse);
    expect(cubit.state.canToggle(palmVillage), isTrue);

    cubit.toggleVillage(palmVillage);
    expect(cubit.state.selectedIds, {greenValley.id});
    expect(cubit.state.canToggle(gardenVillage), isTrue);
  });

  test('search matches name, area and governorate, ignoring case', () {
    cubit.search('palm');
    expect(cubit.state.visibleVillages, [palmVillage]);

    cubit.search('GIZA');
    expect(cubit.state.visibleVillages, [palmVillage, gardenVillage]);

    cubit.search('nothing like this');
    expect(cubit.state.visibleVillages, isEmpty);
  });

  test('area filter combines with search and can be cleared', () {
    cubit.setArea('New Cairo');
    expect(cubit.state.visibleVillages, [greenValley, sunsetResidence]);

    cubit.search('sunset');
    expect(cubit.state.visibleVillages, [sunsetResidence]);

    cubit.setArea(null);
    expect(cubit.state.area, isNull);
    expect(cubit.state.visibleVillages, [sunsetResidence]);
  });

  test('filtering keeps the current selection', () {
    cubit
      ..toggleVillage(greenValley)
      ..setArea('Sheikh Zayed');

    expect(cubit.state.visibleVillages, [gardenVillage]);
    expect(cubit.state.selectedVillages, [greenValley]);
  });

  test('repeating the same search or area emits nothing', () async {
    final emitted = <BrokerVillageSelectionState>[];
    final subscription = cubit.stream.listen(emitted.add);

    cubit
      ..search('')
      ..setArea(null);
    await Future<void>.delayed(Duration.zero);

    expect(emitted, isEmpty);
    await subscription.cancel();
  });
}
