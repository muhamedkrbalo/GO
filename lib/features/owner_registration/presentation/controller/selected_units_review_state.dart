part of 'selected_units_review_cubit.dart';

class SelectedUnitsReviewState extends Equatable {
  const SelectedUnitsReviewState({required this.units, this.hasChanges = false});

  final List<OwnerUnit> units;
  final bool hasChanges;

  int get unitCount => units.length;

  int get villageCount => {for (final unit in units) unit.village}.length;

  int get buildingCount => {
    for (final unit in units)
      if (unit.building != null) (unit.village, unit.building),
  }.length;

  bool get canContinue => units.isNotEmpty;

  SelectedUnitsReviewState copyWith({List<OwnerUnit>? units, bool? hasChanges}) {
    return SelectedUnitsReviewState(
      units: units ?? this.units,
      hasChanges: hasChanges ?? this.hasChanges,
    );
  }

  @override
  List<Object?> get props => [units, hasChanges];
}
