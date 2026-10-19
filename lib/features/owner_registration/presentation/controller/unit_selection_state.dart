part of 'unit_selection_cubit.dart';

class UnitSelectionState extends Equatable {
  const UnitSelectionState({
    required this.units,
    required this.visibleUnits,
    this.query = '',
    this.village,
    this.building,
    this.unitType,
    this.selectedIds = const {},
    this.showSelectedOnly = false,
  });

  final List<OwnerUnit> units;
  final List<OwnerUnit> visibleUnits;
  final String query;
  final String? village;
  final String? building;
  final UnitType? unitType;
  final Set<String> selectedIds;
  final bool showSelectedOnly;

  int get selectedCount => selectedIds.length;

  List<OwnerUnit> get selectedUnits => [
    for (final unit in units)
      if (selectedIds.contains(unit.id)) unit,
  ];

  List<String> get villages => {for (final unit in units) unit.village}.toList();

  List<String> get buildings => {
    for (final unit in units)
      if (unit.building != null && (village == null || unit.village == village)) unit.building!,
  }.toList();

  @override
  List<Object?> get props => [
    visibleUnits,
    query,
    village,
    building,
    unitType,
    selectedIds,
    showSelectedOnly,
  ];
}
