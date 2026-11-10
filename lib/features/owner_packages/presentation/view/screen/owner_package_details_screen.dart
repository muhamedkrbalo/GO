import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/owner_package.dart';
import '../widget/owner_package_feature_list.dart';
import '../widget/owner_packages_intro.dart';
import '../widget/package_activation_fee_card.dart';
import '../widget/package_details_bottom_bar.dart';
import '../widget/package_details_section_card.dart';
import '../widget/package_price_summary_card.dart';
import '../widget/package_resource_limits_card.dart';

class OwnerPackageDetailsScreen extends StatelessWidget {
  const OwnerPackageDetailsScreen({super.key, required this.package});

  final OwnerPackage package;

  static const _contentPadding = EdgeInsetsDirectional.fromSTEB(21, 27, 21, 34);
  static const _introGap = SizedBox(height: 22);
  static const _featuresSpacing = 7.0;
  static const _termsGap = 6.0;
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final activationFee = package.activationFee;
    final termsSummary = package.termsSummary;

    return Scaffold(
      backgroundColor: colors.canvas,
      appBar: CustomAppBar(title: AppLocaleKey.packageDetails.tr()),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: _contentPadding,
              children: [
                OwnerPackagesIntro(
                  eyebrow: AppLocaleKey.ownerPackage.tr(),
                  title: package.name,
                  subtitle: AppLocaleKey.packageDetailsDescription.tr(),
                ),
                _introGap,
                PackagePriceSummaryCard(
                  price: package.price,
                  durationMonths: package.durationMonths,
                ),
                if (activationFee != null) ...[
                  AppSpacing.gapV15,
                  PackageActivationFeeCard(fee: activationFee),
                ],
                AppSpacing.gapV15,
                PackageDetailsSectionCard(
                  title: AppLocaleKey.includedFeatures.tr(),
                  child: OwnerPackageFeatureList(
                    features: package.features,
                    spacing: _featuresSpacing,
                  ),
                ),
                AppSpacing.gapV15,
                PackageResourceLimitsCard(
                  unitsLimit: package.unitsLimit,
                  businessUsersLimit: package.businessUsersLimit,
                ),
                if (package.excludedFeatures.isNotEmpty) ...[
                  AppSpacing.gapV15,
                  PackageDetailsSectionCard(
                    title: AppLocaleKey.excludedFeatures.tr(),
                    child: OwnerPackageFeatureList(
                      features: package.excludedFeatures,
                      isIncluded: false,
                      spacing: _featuresSpacing,
                    ),
                  ),
                ],
                if (termsSummary != null) ...[
                  AppSpacing.gapV15,
                  PackageDetailsSectionCard(
                    title: AppLocaleKey.subscriptionTerms.tr(),
                    isTitleBold: true,
                    titleGap: _termsGap,
                    child: Text(
                      termsSummary,
                      style: AppTextStyles.xxxxxsMedium.copyWith(
                        color: colors.textMuted,
                        fontWeight: FontWeight.w400,
                        height: _textHeight,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          PackageDetailsBottomBar(
            onConfirm: () => context.pop(package.id),
            onBack: () => context.pop(),
          ),
        ],
      ),
    );
  }
}
