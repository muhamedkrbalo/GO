part of 'owner_packages_cubit.dart';

class OwnerPackagesState extends Equatable {
  const OwnerPackagesState({this.packages = const [], this.selectedId});

  final List<OwnerPackage> packages;
  final String? selectedId;

  OwnerPackage? get selectedPackage {
    for (final package in packages) {
      if (package.id == selectedId) return package;
    }
    return null;
  }

  bool get canContinue => selectedPackage != null;

  bool isSelected(String packageId) => packageId == selectedId;

  OwnerPackagesState copyWith({List<OwnerPackage>? packages, String? selectedId}) {
    return OwnerPackagesState(
      packages: packages ?? this.packages,
      selectedId: selectedId ?? this.selectedId,
    );
  }

  @override
  List<Object?> get props => [packages, selectedId];
}
