import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/owner_unit.dart';

part 'selected_units_review_state.dart';

class SelectedUnitsReviewCubit extends Cubit<SelectedUnitsReviewState> {
  SelectedUnitsReviewCubit(List<OwnerUnit> units)
    : super(SelectedUnitsReviewState(units: List.unmodifiable(units)));

  void remove(OwnerUnit unit) {
    if (!state.units.contains(unit)) return;
    emit(
      state.copyWith(
        units: List.unmodifiable(state.units.where((item) => item != unit)),
        hasChanges: true,
      ),
    );
  }
}
