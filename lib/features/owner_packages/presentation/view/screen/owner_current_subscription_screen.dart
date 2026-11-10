import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/owner_subscription.dart';
import '../widget/covered_relationships_card.dart';
import '../widget/owner_package_feature_list.dart';
import '../widget/owner_packages_intro.dart';
import '../widget/package_details_section_card.dart';
import '../widget/package_text_section_card.dart';
import '../widget/subscription_actions_grid.dart';
import '../widget/subscription_details_card.dart';

class OwnerCurrentSubscriptionScreen extends StatelessWidget {
  const OwnerCurrentSubscriptionScreen({
    super.key,
    required this.subscription,
    this.showBackButton = true,
  });

  final OwnerSubscription subscription;
  final bool showBackButton;

  static const _contentPadding = EdgeInsetsDirectional.fromSTEB(21, 27, 21, 34);
  static const _introGap = SizedBox(height: 22);
  static const _featuresSpacing = 7.0;

  @override
  Widget build(BuildContext context) {
    final previousPackageName = subscription.previousPackageName;

    return Scaffold(
      backgroundColor: context.customColors.canvas,
      appBar: CustomAppBar(
        title: AppLocaleKey.currentSubscription.tr(),
        showBackButton: showBackButton,
      ),
      body: ListView(
        padding: _contentPadding,
        children: [
          OwnerPackagesIntro(
            eyebrow: AppLocaleKey.subscriptionAccount.tr(),
            title: AppLocaleKey.currentSubscriptionDetails.tr(),
            subtitle: AppLocaleKey.currentSubscriptionDescription.tr(),
          ),
          _introGap,
          SubscriptionDetailsCard(subscription: subscription),
          AppSpacing.gapV15,
          CoveredRelationshipsCard(relationships: subscription.coveredRelationships),
          AppSpacing.gapV15,
          PackageDetailsSectionCard(
            title: AppLocaleKey.includedFeatures.tr(),
            child: OwnerPackageFeatureList(
              features: subscription.package.features,
              spacing: _featuresSpacing,
            ),
          ),
          if (previousPackageName != null) ...[
            AppSpacing.gapV15,
            PackageTextSectionCard(
              title: AppLocaleKey.previousSubscription.tr(),
              text: previousPackageName,
              isTitleBold: false,
            ),
          ],
          AppSpacing.gapV16,
          SubscriptionActionsGrid(subscription: subscription),
        ],
      ),
    );
  }
}
