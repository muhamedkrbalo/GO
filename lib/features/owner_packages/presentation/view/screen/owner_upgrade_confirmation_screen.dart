import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/package_change.dart';
import '../widget/egp_amount.dart';
import '../widget/owner_packages_intro.dart';
import '../widget/package_actions_bottom_bar.dart';
import '../widget/package_info_table_card.dart';
import '../widget/package_text_section_card.dart';

class OwnerUpgradeConfirmationScreen extends StatelessWidget {
  const OwnerUpgradeConfirmationScreen({super.key, required this.change});

  final PackageChange change;

  static const _contentPadding = EdgeInsetsDirectional.fromSTEB(21, 27, 21, 34);
  static const _introGap = SizedBox(height: 22);

  @override
  Widget build(BuildContext context) {
    final target = change.target;
    final termsSummary = target.termsSummary;
    final newLimits = [
      AppLocaleKey.packageUnitsLimit.tr(args: ['${target.unitsLimit}']),
      AppLocaleKey.packageBusinessUsersLimit.tr(args: ['${target.businessUsersLimit}']),
    ].join(' · ');

    return Scaffold(
      backgroundColor: context.customColors.canvas,
      appBar: CustomAppBar(title: AppLocaleKey.upgradeConfirmation.tr()),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: _contentPadding,
              children: [
                OwnerPackagesIntro(
                  eyebrow: AppLocaleKey.confirmPackageChange.tr(),
                  title: AppLocaleKey.confirmUpgrade.tr(),
                  subtitle: AppLocaleKey.reviewCommercialRules.tr(),
                ),
                _introGap,
                PackageInfoTableCard(
                  lines: [
                    (AppLocaleKey.currentPackage.tr(), change.current.name),
                    (AppLocaleKey.newPackage.tr(), target.name),
                    (AppLocaleKey.newLimits.tr(), newLimits),
                    (
                      AppLocaleKey.additionalAmountDue.tr(),
                      formatEgpAmount(change.additionalAmountDue),
                    ),
                  ],
                ),
                if (termsSummary != null) ...[
                  AppSpacing.gapV15,
                  PackageTextSectionCard(
                    title: AppLocaleKey.applicableTerms.tr(),
                    text: termsSummary,
                  ),
                ],
              ],
            ),
          ),
          PackageActionsBottomBar(confirmLabel: AppLocaleKey.confirmUpgrade.tr(), onConfirm: null),
        ],
      ),
    );
  }
}
