import 'package:equatable/equatable.dart';

import '../../../../core/locale/app_locale_key.dart';

enum BrokerVillageStatus {
  available(AppLocaleKey.available),
  unavailable(AppLocaleKey.unavailable),
  alreadyAssigned(AppLocaleKey.alreadyAssigned);

  const BrokerVillageStatus(this.labelKey);

  final String labelKey;

  bool get isSelectable => this == BrokerVillageStatus.available;
}

class BrokerVillage extends Equatable {
  const BrokerVillage({
    required this.id,
    required this.name,
    required this.area,
    required this.governorate,
    required this.status,
  });

  final String id;
  final String name;
  final String area;
  final String governorate;
  final BrokerVillageStatus status;

  bool matches(String query) {
    final value = query.trim().toLowerCase();
    if (value.isEmpty) return true;
    return name.toLowerCase().contains(value) ||
        area.toLowerCase().contains(value) ||
        governorate.toLowerCase().contains(value);
  }

  @override
  List<Object?> get props => [id];
}
