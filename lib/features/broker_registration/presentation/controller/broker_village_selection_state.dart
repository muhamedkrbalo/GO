part of 'broker_village_selection_cubit.dart';

class BrokerVillageSelectionState extends Equatable {
  const BrokerVillageSelectionState({
    required this.villages,
    required this.visibleVillages,
    required this.maxSelection,
    this.query = '',
    this.area,
    this.selectedIds = const {},
  });

  final List<BrokerVillage> villages;
  final List<BrokerVillage> visibleVillages;
  final int maxSelection;
  final String query;
  final String? area;
  final Set<String> selectedIds;

  int get selectedCount => selectedIds.length;

  bool get isLimitReached => selectedCount >= maxSelection;

  bool get canSubmit => selectedIds.isNotEmpty;

  List<String> get areas => {for (final village in villages) village.area}.toList();

  List<BrokerVillage> get selectedVillages => [
    for (final village in villages)
      if (selectedIds.contains(village.id)) village,
  ];

  bool isSelected(BrokerVillage village) => selectedIds.contains(village.id);

  bool canToggle(BrokerVillage village) =>
      village.status.isSelectable && (isSelected(village) || !isLimitReached);

  BrokerVillageSelectionState copyWith({Set<String>? selectedIds}) {
    return BrokerVillageSelectionState(
      villages: villages,
      visibleVillages: visibleVillages,
      maxSelection: maxSelection,
      query: query,
      area: area,
      selectedIds: selectedIds ?? this.selectedIds,
    );
  }

  @override
  List<Object?> get props => [villages, visibleVillages, maxSelection, query, area, selectedIds];
}
