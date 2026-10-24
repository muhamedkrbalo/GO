import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/owner_unit.dart';

part 'unit_selection_state.dart';

class UnitSelectionCubit extends Cubit<UnitSelectionState> {
  UnitSelectionCubit(List<OwnerUnit> units)
    : super(UnitSelectionState(units: units, visibleUnits: units));

  void search(String query) {
    if (query == state.query) return;
    _apply(query: query);
  }

  void setVillage(String? village) {
    final building = state.building;
    final keepsBuilding =
        building == null ||
        village == null ||
        state.units.any((unit) => unit.village == village && unit.building == building);
    _apply(village: village, building: keepsBuilding ? building : null);
  }

  void setBuilding(String? building) => _apply(building: building);

  void setUnitType(UnitType? unitType) => _apply(unitType: unitType);

  void toggleUnit(OwnerUnit unit) {
    if (!unit.status.isSelectable) return;
    final selectedIds = {...state.selectedIds};
    if (!selectedIds.remove(unit.id)) selectedIds.add(unit.id);
    _apply(selectedIds: selectedIds);
  }

  void toggleShowSelectedOnly() => _apply(showSelectedOnly: !state.showSelectedOnly);

  void _apply({
    String? query,
    Object? village = _keep,
    Object? building = _keep,
    Object? unitType = _keep,
    Set<String>? selectedIds,
    bool? showSelectedOnly,
  }) {
    final nextQuery = query ?? state.query;
    final nextVillage = identical(village, _keep) ? state.village : village as String?;
    final nextBuilding = identical(building, _keep) ? state.building : building as String?;
    final nextUnitType = identical(unitType, _keep) ? state.unitType : unitType as UnitType?;
    final nextSelected = selectedIds ?? state.selectedIds;
    final nextShowSelected =
        (showSelectedOnly ?? state.showSelectedOnly) && nextSelected.isNotEmpty;

    emit(
      UnitSelectionState(
        units: state.units,
        visibleUnits: [
          for (final unit in state.units)
            if (unit.matches(nextQuery) &&
                (nextVillage == null || unit.village == nextVillage) &&
                (nextBuilding == null || unit.building == nextBuilding) &&
                (nextUnitType == null || unit.type == nextUnitType) &&
                (!nextShowSelected || nextSelected.contains(unit.id)))
              unit,
        ],
        query: nextQuery,
        village: nextVillage,
        building: nextBuilding,
        unitType: nextUnitType,
        selectedIds: nextSelected,
        showSelectedOnly: nextShowSelected,
      ),
    );
  }

  static const _keep = Object();
}
