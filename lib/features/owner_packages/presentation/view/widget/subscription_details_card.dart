import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/cache/hive/hive_methods.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../data/model/owner_subscription.dart';
import 'package_info_table_card.dart';

class SubscriptionDetailsCard extends StatelessWidget {
  const SubscriptionDetailsCard({super.key, required this.subscription});

  final OwnerSubscription subscription;

  static const _datePattern = 'dd MMM yyyy';

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat(_datePattern, HiveMethods.getLang())..useNativeDigits = false;

    return PackageInfoTableCard(
      lines: [
        (AppLocaleKey.packageName.tr(), subscription.package.name),
        (AppLocaleKey.packageType.tr(), subscription.packageType.shortLabelKey.tr()),
        (AppLocaleKey.status.tr(), subscription.status.labelKey.tr()),
        (AppLocaleKey.startDate.tr(), dateFormat.format(subscription.startDate)),
        (AppLocaleKey.endDate.tr(), dateFormat.format(subscription.endDate)),
        (
          AppLocaleKey.duration.tr(),
          AppLocaleKey.monthsCount.tr(args: ['${subscription.package.durationMonths}']),
        ),
        (AppLocaleKey.renewalDate.tr(), dateFormat.format(subscription.renewalDate)),
      ],
    );
  }
}
