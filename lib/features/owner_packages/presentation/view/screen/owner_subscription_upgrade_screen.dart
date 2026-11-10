import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/owner_package.dart';
import '../../../data/model/package_change.dart';
import '../widget/current_package_banner.dart';
import '../widget/no_package_options_message.dart';
import '../widget/owner_packages_bottom_bar.dart';
import '../widget/owner_packages_intro.dart';
import '../widget/owner_packages_sliver_list.dart';

class OwnerSubscriptionUpgradeScreen extends StatelessWidget {
  const OwnerSubscriptionUpgradeScreen({super.key, required this.currentPackage});

  final OwnerPackage currentPackage;

  static const _contentPadding = EdgeInsetsDirectional.fromSTEB(21, 27, 21, 34);
  static const _introToBannerGap = SliverToBoxAdapter(child: SizedBox(height: 19));
  static const _bannerToCardsGap = SliverToBoxAdapter(child: SizedBox(height: 13));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.customColors.canvas,
      appBar: CustomAppBar(title: AppLocaleKey.upgradeSubscription.tr()),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: _contentPadding,
                  sliver: SliverMainAxisGroup(
                    slivers: [
                      SliverToBoxAdapter(
                        child: OwnerPackagesIntro(
                          eyebrow: AppLocaleKey.packageChange.tr(),
                          title: AppLocaleKey.upgradeYourPackage.tr(),
                          subtitle: AppLocaleKey.chooseHigherPackage.tr(),
                        ),
                      ),
                      _introToBannerGap,
                      SliverToBoxAdapter(child: CurrentPackageBanner(package: currentPackage)),
                      _bannerToCardsGap,
                      const OwnerPackagesSliverList(),
                      SliverToBoxAdapter(
                        child: NoPackageOptionsMessage(message: AppLocaleKey.noUpgradeOptions.tr()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          OwnerPackagesBottomBar(
            label: AppLocaleKey.reviewUpgrade.tr(),
            onContinue: (package) => context.pushNamed(
              RouteNames.ownerUpgradeConfirmation,
              extra: PackageChange(current: currentPackage, target: package),
            ),
          ),
        ],
      ),
    );
  }
}
