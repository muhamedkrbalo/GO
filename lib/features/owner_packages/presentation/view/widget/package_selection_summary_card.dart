import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../data/model/owner_package.dart';
import 'egp_amount.dart';
import 'package_info_table_card.dart';

class PackageSelectionSummaryCard extends StatelessWidget {
  const PackageSelectionSummaryCard({
    super.key,
    required this.package,
    this.isCompact = false,
    this.showDuration = true,
  });

  final OwnerPackage package;
  final bool isCompact;
  final bool showDuration;

  @override
  Widget build(BuildContext context) {
    final activationFee = package.activationFee;

    return PackageInfoTableCard(
      isCompact: isCompact,
      lines: [
        (AppLocaleKey.selectedPackage.tr(), package.name),
        (AppLocaleKey.packagePrice.tr(), formatEgpAmount(package.price)),
        if (showDuration)
          (
            AppLocaleKey.subscriptionDuration.tr(),
            AppLocaleKey.monthsCount.tr(args: ['${package.durationMonths}']),
          ),
        if (activationFee != null)
          (AppLocaleKey.registrationAndActivationFee.tr(), formatEgpAmount(activationFee)),
      ],
      totalLine: (AppLocaleKey.totalAmountDue.tr(), formatEgpAmount(package.totalDueOnActivation)),
    );
  }
}
