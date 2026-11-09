import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/broker_village.dart';

part 'broker_village_selection_state.dart';

class BrokerVillageSelectionCubit extends Cubit<BrokerVillageSelectionState> {
  BrokerVillageSelectionCubit(List<BrokerVillage> villages, {int maxSelection = 3})
    : super(
        BrokerVillageSelectionState(
          villages: villages,
          visibleVillages: villages,
          maxSelection: maxSelection,
        ),
      );

  void search(String query) {
    if (query == state.query) return;
    _apply(query: query);
  }

  void setArea(String? area) {
    if (area == state.area) return;
    _apply(area: area);
  }

  void toggleVillage(BrokerVillage village) {
    if (!state.canToggle(village)) return;
    final selectedIds = {...state.selectedIds};
    if (!selectedIds.remove(village.id)) selectedIds.add(village.id);
    emit(state.copyWith(selectedIds: Set.unmodifiable(selectedIds)));
  }

  void _apply({String? query, Object? area = _keep}) {
    final nextQuery = query ?? state.query;
    final nextArea = identical(area, _keep) ? state.area : area as String?;

    emit(
      BrokerVillageSelectionState(
        villages: state.villages,
        visibleVillages: List.unmodifiable([
          for (final village in state.villages)
            if (village.matches(nextQuery) && (nextArea == null || village.area == nextArea))
              village,
        ]),
        maxSelection: state.maxSelection,
        query: nextQuery,
        area: nextArea,
        selectedIds: state.selectedIds,
      ),
    );
  }

  static const _keep = Object();
}
