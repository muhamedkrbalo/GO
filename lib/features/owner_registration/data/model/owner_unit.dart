import 'package:equatable/equatable.dart';

import '../../../../core/locale/app_locale_key.dart';

enum UnitType {
  apartment(AppLocaleKey.apartment),
  villa(AppLocaleKey.villa),
  chalet(AppLocaleKey.chalet),
  cabin(AppLocaleKey.cabin);

  const UnitType(this.labelKey);

  final String labelKey;
}

enum UnitStatus {
  eligible(AppLocaleKey.eligible),
  alreadyOwned(AppLocaleKey.alreadyOwned, reasonKey: AppLocaleKey.registeredToAnotherOwner),
  notEligible(AppLocaleKey.notEligible, reasonKey: AppLocaleKey.unitNotEligible),
  inactive(AppLocaleKey.inactive, reasonKey: AppLocaleKey.unitInactive);

  const UnitStatus(this.labelKey, {this.reasonKey});

  final String labelKey;
  final String? reasonKey;

  bool get isSelectable => this == UnitStatus.eligible;
}

class OwnerUnit extends Equatable {
  const OwnerUnit({
    required this.id,
    required this.name,
    required this.village,
    required this.location,
    required this.type,
    required this.status,
    this.building,
  });

  final String id;
  final String name;
  final String village;
  final String? building;
  final String location;
  final UnitType type;
  final UnitStatus status;

  bool matches(String query) {
    final value = query.trim().toLowerCase();
    if (value.isEmpty) return true;
    return name.toLowerCase().contains(value) || location.toLowerCase().contains(value);
  }

  @override
  List<Object?> get props => [id];
}
