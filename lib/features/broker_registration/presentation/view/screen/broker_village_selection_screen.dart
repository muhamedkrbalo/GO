import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/registration_form/registration_intro.dart';
import '../../../../../core/custom_widgets/registration_form/registration_notice.dart';
import '../../../../../core/custom_widgets/registration_step_header/registration_step_header.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../widget/broker_selected_villages_counter.dart';
import '../widget/broker_village_filters.dart';
import '../widget/broker_village_list_sliver.dart';
import '../widget/broker_village_selection_footer.dart';

class BrokerVillageSelectionScreen extends StatelessWidget {
  const BrokerVillageSelectionScreen({super.key});

  static const _contentPadding = EdgeInsetsDirectional.fromSTEB(22, 28, 22, 34);
  static const _introToFiltersGap = SizedBox(height: 22);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.customColors.canvas,
      bottomNavigationBar: const BrokerVillageSelectionFooter(),
      body: Column(
        children: [
          RegistrationStepHeader(title: AppLocaleKey.villageAssignment.tr()),
          Expanded(
            child: CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                SliverPadding(
                  padding: _contentPadding,
                  sliver: SliverMainAxisGroup(
                    slivers: [
                      SliverList.list(
                        children: [
                          RegistrationIntro(
                            eyebrow: AppLocaleKey.approvedBroker.tr(),
                            title: AppLocaleKey.selectVillages.tr(),
                            subtitle: AppLocaleKey.chooseBrokerVillages.tr(),
                          ),
                          _introToFiltersGap,
                          const BrokerVillageFilters(),
                          AppSpacing.gapV12,
                          const BrokerSelectedVillagesCounter(),
                          AppSpacing.gapV16,
                        ],
                      ),
                      const BrokerVillageListSliver(),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(top: AppSpacing.l16),
                          child: RegistrationNotice(
                            message: AppLocaleKey.villageRequestsReviewNotice.tr(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
