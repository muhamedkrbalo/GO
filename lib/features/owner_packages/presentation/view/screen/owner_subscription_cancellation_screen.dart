import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/owner_subscription.dart';
import '../widget/owner_packages_intro.dart';
import '../widget/package_actions_bottom_bar.dart';
import '../widget/package_info_table_card.dart';
import '../widget/package_text_section_card.dart';

class OwnerSubscriptionCancellationScreen extends StatelessWidget {
  const OwnerSubscriptionCancellationScreen({super.key, required this.subscription});

  final OwnerSubscription subscription;

  static const _contentPadding = EdgeInsetsDirectional.fromSTEB(21, 27, 21, 34);
  static const _introGap = SizedBox(height: 22);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.customColors.canvas,
      appBar: CustomAppBar(title: AppLocaleKey.cancelSubscription.tr()),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: _contentPadding,
              children: [
                OwnerPackagesIntro(
                  eyebrow: AppLocaleKey.subscriptionCancellation.tr(),
                  title: AppLocaleKey.cancelSubscriptionQuestion.tr(),
                  subtitle: AppLocaleKey.cancelSubscriptionDescription.tr(),
                ),
                _introGap,
                PackageInfoTableCard(
                  lines: [
                    (AppLocaleKey.currentPackage.tr(), subscription.package.name),
                    (AppLocaleKey.currentStatus.tr(), subscription.status.labelKey.tr()),
                    (AppLocaleKey.effectiveDate.tr(), AppLocaleKey.effectiveAtPeriodEnd.tr()),
                  ],
                ),
                AppSpacing.gapV15,
                PackageTextSectionCard(
                  title: AppLocaleKey.cancellationTerms.tr(),
                  text: AppLocaleKey.cancellationTermsDescription.tr(),
                ),
              ],
            ),
          ),
          PackageActionsBottomBar(
            confirmLabel: AppLocaleKey.confirmCancellation.tr(),
            backLabel: AppLocaleKey.keepSubscription.tr(),
            onConfirm: null,
            onBack: () => context.pop(),
          ),
        ],
      ),
    );
  }
}
