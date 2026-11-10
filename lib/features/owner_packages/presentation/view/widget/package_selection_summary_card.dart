import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/owner_package.dart';
import 'egp_amount.dart';
import 'package_info_row.dart';

class PackageSelectionSummaryCard extends StatelessWidget {
  const PackageSelectionSummaryCard({super.key, required this.package});

  final OwnerPackage package;

  static const _radius = BorderRadius.all(Radius.circular(13));
  static const _borderWidth = 1.6;
  static const _rowPadding = EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 9);
  static const _rowMinHeight = 43.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final activationFee = package.activationFee;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: _radius,
        border: Border.all(color: colors.subtleBorder, width: _borderWidth),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PackageInfoRow(
            label: AppLocaleKey.selectedPackage.tr(),
            value: package.name,
            showDivider: true,
            padding: _rowPadding,
            minHeight: _rowMinHeight,
          ),
          PackageInfoRow(
            label: AppLocaleKey.packagePrice.tr(),
            value: formatEgpAmount(package.price),
            showDivider: true,
            padding: _rowPadding,
            minHeight: _rowMinHeight,
          ),
          PackageInfoRow(
            label: AppLocaleKey.subscriptionDuration.tr(),
            value: AppLocaleKey.monthsCount.tr(args: ['${package.durationMonths}']),
            showDivider: true,
            padding: _rowPadding,
            minHeight: _rowMinHeight,
          ),
          if (activationFee != null)
            PackageInfoRow(
              label: AppLocaleKey.registrationAndActivationFee.tr(),
              value: formatEgpAmount(activationFee),
              showDivider: true,
              padding: _rowPadding,
              minHeight: _rowMinHeight,
            ),
          PackageInfoRow(
            label: AppLocaleKey.totalAmountDue.tr(),
            value: formatEgpAmount(package.totalDueOnActivation),
            isHighlighted: true,
            padding: _rowPadding,
            minHeight: _rowMinHeight,
          ),
        ],
      ),
    );
  }
}
