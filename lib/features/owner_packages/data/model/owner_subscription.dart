import 'package:equatable/equatable.dart';

import '../../../../core/locale/app_locale_key.dart';
import '../../../auth/data/model/business_role.dart';
import 'owner_package.dart';

enum SubscriptionStatus {
  active(AppLocaleKey.active),
  pending(AppLocaleKey.pending),
  cancelled(AppLocaleKey.cancelled),
  expired(AppLocaleKey.expired);

  const SubscriptionStatus(this.labelKey);

  final String labelKey;
}

extension BusinessRoleShortLabel on BusinessRole {
  String get shortLabelKey => switch (this) {
    BusinessRole.owner => AppLocaleKey.owner,
    BusinessRole.broker => AppLocaleKey.broker,
  };
}

class OwnerSubscription extends Equatable {
  const OwnerSubscription({
    required this.package,
    required this.packageType,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.renewalDate,
    required this.coveredRelationships,
    this.previousPackageName,
  });

  final OwnerPackage package;
  final BusinessRole packageType;
  final SubscriptionStatus status;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime renewalDate;
  final List<BusinessRole> coveredRelationships;
  final String? previousPackageName;

  List<OwnerPackage> upgradeOptions(List<OwnerPackage> catalog) => [
    for (final option in catalog)
      if (option.price > package.price) option,
  ];

  @override
  List<Object?> get props => [
    package,
    packageType,
    status,
    startDate,
    endDate,
    renewalDate,
    coveredRelationships,
    previousPackageName,
  ];
}
