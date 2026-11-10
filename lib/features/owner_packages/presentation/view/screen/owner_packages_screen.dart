import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../widget/owner_package_action_button.dart';
import '../widget/owner_packages_bottom_bar.dart';
import '../widget/owner_packages_intro.dart';
import '../widget/owner_packages_sliver_list.dart';

class OwnerPackagesScreen extends StatelessWidget {
  const OwnerPackagesScreen({super.key});

  static const _contentPadding = EdgeInsetsDirectional.fromSTEB(21, 27, 21, 34);
  static const _introToCardsGap = SliverToBoxAdapter(child: SizedBox(height: 13));
  static const _compareButtonPadding = EdgeInsetsDirectional.only(top: 13);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.customColors.canvas,
      appBar: CustomAppBar(title: AppLocaleKey.ownerPackages.tr()),
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
                          eyebrow: AppLocaleKey.eligiblePackages.tr(),
                          title: AppLocaleKey.chooseYourPackage.tr(),
                          subtitle: AppLocaleKey.choosePackageDescription.tr(),
                        ),
                      ),
                      _introToCardsGap,
                      const OwnerPackagesSliverList(),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: _compareButtonPadding,
                          child: OwnerPackageActionButton(
                            label: AppLocaleKey.comparePackages.tr(),
                            onPressed: null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const OwnerPackagesBottomBar(),
        ],
      ),
    );
  }
}
