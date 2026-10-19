import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/owner_unit.dart';
import '../../data/model/ownership_type.dart';

part 'ownership_details_state.dart';

class OwnershipDetailsCubit extends Cubit<OwnershipDetailsState> {
  OwnershipDetailsCubit(List<OwnerUnit> units) : super(OwnershipDetailsState(units: units));

  void setType(String unitId, OwnershipType type) {
    _update(unitId, (details) => details.copyWith(type: type));
  }

  void setDate(String unitId, DateTime date) {
    _update(unitId, (details) => details.copyWith(date: date));
  }

  void _update(String unitId, UnitOwnership Function(UnitOwnership details) change) {
    emit(
      OwnershipDetailsState(
        units: state.units,
        details: {...state.details, unitId: change(state.detailsOf(unitId))},
      ),
    );
  }
}
