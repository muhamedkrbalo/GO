part of 'ownership_details_cubit.dart';

class UnitOwnership extends Equatable {
  const UnitOwnership({this.type, this.date});

  final OwnershipType? type;
  final DateTime? date;

  bool get isComplete => type != null && date != null;

  UnitOwnership copyWith({OwnershipType? type, DateTime? date}) {
    return UnitOwnership(type: type ?? this.type, date: date ?? this.date);
  }

  @override
  List<Object?> get props => [type, date];
}

class OwnershipDetailsState extends Equatable {
  const OwnershipDetailsState({required this.units, this.details = const {}});

  final List<OwnerUnit> units;
  final Map<String, UnitOwnership> details;

  UnitOwnership detailsOf(String unitId) => details[unitId] ?? const UnitOwnership();

  int get completedCount => units.where((unit) => detailsOf(unit.id).isComplete).length;

  bool get isComplete => units.isNotEmpty && completedCount == units.length;

  @override
  List<Object?> get props => [units, details];
}
