import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/owner_unit.dart';
import '../../data/model/ownership_type.dart';
import '../../data/model/unit_details_status.dart';

part 'ownership_details_state.dart';

class OwnershipDetailsCubit extends Cubit<OwnershipDetailsState> {
  OwnershipDetailsCubit(List<OwnerUnit> units, {Map<String, UnitOwnership> details = const {}})
    : super(_initialState(units, details));

  static OwnershipDetailsState _initialState(
    List<OwnerUnit> units,
    Map<String, UnitOwnership> details,
  ) {
    final kept = {for (final unit in units) unit.id: ?details[unit.id]};
    return OwnershipDetailsState(
      units: List.unmodifiable(units),
      details: kept,
      savedIds: {
        for (final entry in kept.entries)
          if (entry.value.isValid) entry.key,
      },
    );
  }

  void selectUnit(int index) {
    if (index == state.activeIndex || index < 0 || index >= state.units.length) return;
    emit(state.copyWith(activeIndex: index));
  }

  void setType(String unitId, OwnershipType type) {
    _update(unitId, (details) => details.copyWith(type: type));
  }

  void setDate(String unitId, DateTime date) {
    _update(unitId, (details) => details.copyWith(date: date));
  }

  void setDocumentNumber(String unitId, String value) {
    _update(unitId, (details) => details.copyWith(documentNumber: value));
  }

  void setDocumentDate(String unitId, DateTime date) {
    _update(unitId, (details) => details.copyWith(documentDate: date));
  }

  void setNotes(String unitId, String value) {
    _update(unitId, (details) => details.copyWith(notes: value));
  }

  void saveActiveUnit() {
    if (!state.canSaveActive) return;
    final unitId = state.activeUnit.id;
    if (state.savedIds.contains(unitId)) return;
    emit(state.copyWith(savedIds: {...state.savedIds, unitId}));
  }

  void continueToNextUnit() {
    saveActiveUnit();
    if (!state.savedIds.contains(state.activeUnit.id)) return;
    final next = state.nextPendingIndex;
    if (next != null) emit(state.copyWith(activeIndex: next));
  }

  void _update(String unitId, UnitOwnership Function(UnitOwnership details) change) {
    final current = state.detailsOf(unitId);
    final updated = change(current);
    if (updated == current) return;
    emit(
      state.copyWith(
        details: {...state.details, unitId: updated},
        savedIds: {...state.savedIds}..remove(unitId),
      ),
    );
  }
}
