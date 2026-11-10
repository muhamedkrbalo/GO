import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/custom_widgets/accent_notice/accent_notice.dart';
import '../../../../../core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/owner_package.dart';
import '../widget/owner_packages_intro.dart';
import '../widget/package_actions_bottom_bar.dart';
import '../widget/package_selection_summary_card.dart';
import '../widget/package_terms_card.dart';

class OwnerPackageConfirmationScreen extends StatelessWidget {
  const OwnerPackageConfirmationScreen({super.key, required this.package});

  final OwnerPackage package;

  static const _contentPadding = EdgeInsetsDirectional.fromSTEB(21, 27, 21, 34);
  static const _introGap = SizedBox(height: 22);
  static const _noticeGap = SizedBox(height: 14);

  @override
  Widget build(BuildContext context) {
    final termsSummary = package.termsSummary;

    return Scaffold(
      backgroundColor: context.customColors.canvas,
      appBar: CustomAppBar(title: AppLocaleKey.confirmPackageSelection.tr()),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: _contentPadding,
              children: [
                OwnerPackagesIntro(
                  eyebrow: AppLocaleKey.selectionConfirmation.tr(),
                  title: AppLocaleKey.confirmPackageSelection.tr(),
                  subtitle: AppLocaleKey.selectionDoesNotActivateSubscription.tr(),
                ),
                _introGap,
                PackageSelectionSummaryCard(package: package),
                if (termsSummary != null) ...[
                  AppSpacing.gapV15,
                  PackageTermsCard(title: AppLocaleKey.applicableTerms.tr(), summary: termsSummary),
                ],
                _noticeGap,
                AccentNotice(message: AppLocaleKey.packageRevalidationNotice.tr()),
              ],
            ),
          ),
          PackageActionsBottomBar(
            confirmLabel: AppLocaleKey.confirm.tr(),
            backLabel: AppLocaleKey.cancelOrBack.tr(),
            onConfirm: null,
            onBack: () => context.pop(),
          ),
        ],
      ),
    );
  }
}
