import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/owner_package.dart';
import 'egp_amount.dart';
import 'package_info_row.dart';

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

  static const _radius = BorderRadius.all(Radius.circular(13));
  static const _compactRadius = BorderRadius.all(Radius.circular(12));
  static const _borderWidth = 1.6;
  static const _rowPadding = EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 9);
  static const _compactRowPadding = EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 10);
  static const _rowMinHeight = 43.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final activationFee = package.activationFee;
    final rowPadding = isCompact ? _compactRowPadding : _rowPadding;
    final rowMinHeight = isCompact ? 0.0 : _rowMinHeight;
    final lines = <(String, String)>[
      (AppLocaleKey.selectedPackage.tr(), package.name),
      (AppLocaleKey.packagePrice.tr(), formatEgpAmount(package.price)),
      if (showDuration)
        (
          AppLocaleKey.subscriptionDuration.tr(),
          AppLocaleKey.monthsCount.tr(args: ['${package.durationMonths}']),
        ),
      if (activationFee != null)
        (AppLocaleKey.registrationAndActivationFee.tr(), formatEgpAmount(activationFee)),
    ];

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: isCompact ? _compactRadius : _radius,
        border: Border.all(color: colors.subtleBorder, width: _borderWidth),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final (label, value) in lines)
            PackageInfoRow(
              label: label,
              value: value,
              showDivider: true,
              padding: rowPadding,
              minHeight: rowMinHeight,
            ),
          PackageInfoRow(
            label: AppLocaleKey.totalAmountDue.tr(),
            value: formatEgpAmount(package.totalDueOnActivation),
            isHighlighted: true,
            isEmphasized: !isCompact,
            padding: rowPadding,
            minHeight: rowMinHeight,
          ),
        ],
      ),
    );
  }
}
