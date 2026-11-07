part of 'ownership_details_cubit.dart';

class UnitOwnership extends Equatable {
  const UnitOwnership({
    this.type,
    this.date,
    this.documentNumber = '',
    this.documentDate,
    this.notes = '',
  });

  final OwnershipType? type;
  final DateTime? date;
  final String documentNumber;
  final DateTime? documentDate;
  final String notes;

  bool get isValid => type != null;

  bool get isEmpty =>
      type == null &&
      date == null &&
      documentNumber.trim().isEmpty &&
      documentDate == null &&
      notes.trim().isEmpty;

  UnitOwnership copyWith({
    OwnershipType? type,
    DateTime? date,
    String? documentNumber,
    DateTime? documentDate,
    String? notes,
  }) {
    return UnitOwnership(
      type: type ?? this.type,
      date: date ?? this.date,
      documentNumber: documentNumber ?? this.documentNumber,
      documentDate: documentDate ?? this.documentDate,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [type, date, documentNumber, documentDate, notes];
}

class OwnershipDetailsState extends Equatable {
  const OwnershipDetailsState({
    required this.units,
    this.details = const {},
    this.savedIds = const {},
    this.activeIndex = 0,
  });

  final List<OwnerUnit> units;
  final Map<String, UnitOwnership> details;
  final Set<String> savedIds;
  final int activeIndex;

  OwnerUnit get activeUnit => units[activeIndex];

  UnitOwnership detailsOf(String unitId) => details[unitId] ?? const UnitOwnership();

  UnitOwnership get activeDetails => detailsOf(activeUnit.id);

  UnitDetailsStatus statusOf(String unitId) {
    if (savedIds.contains(unitId)) return UnitDetailsStatus.completed;
    return detailsOf(unitId).isEmpty ? UnitDetailsStatus.notStarted : UnitDetailsStatus.inProgress;
  }

  int get completedCount => units.where((unit) => savedIds.contains(unit.id)).length;

  bool get isComplete => units.isNotEmpty && completedCount == units.length;

  bool get canSaveActive => activeDetails.isValid;

  bool get isLastPendingUnit =>
      units.every((unit) => unit.id == activeUnit.id || savedIds.contains(unit.id));

  int? get nextPendingIndex {
    for (var offset = 1; offset < units.length; offset++) {
      final index = (activeIndex + offset) % units.length;
      if (!savedIds.contains(units[index].id)) return index;
    }
    return null;
  }

  OwnershipDetailsState copyWith({
    Map<String, UnitOwnership>? details,
    Set<String>? savedIds,
    int? activeIndex,
  }) {
    return OwnershipDetailsState(
      units: units,
      details: details ?? this.details,
      savedIds: savedIds ?? this.savedIds,
      activeIndex: activeIndex ?? this.activeIndex,
    );
  }

  @override
  List<Object?> get props => [units, details, savedIds, activeIndex];
}
