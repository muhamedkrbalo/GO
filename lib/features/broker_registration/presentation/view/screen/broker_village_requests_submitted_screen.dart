import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/buttons/primary_arrow_button.dart';
import '../../../../../core/custom_widgets/registration_form/registration_sticky_footer.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/broker_village.dart';
import '../widget/broker_submission_hero.dart';
import '../widget/broker_village_request_card.dart';
import '../widget/broker_village_requests_summary_card.dart';

class BrokerVillageRequestsSubmittedScreen extends StatelessWidget {
  const BrokerVillageRequestsSubmittedScreen({super.key, required this.villages});

  final List<BrokerVillage> villages;

  static const _contentPadding = EdgeInsetsDirectional.fromSTEB(22, 28, 22, 34);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.customColors.canvas,
      bottomNavigationBar: RegistrationStickyFooter(
        showSaveAndExit: false,
        child: PrimaryArrowButton(
          text: AppLocaleKey.viewVillageAssignmentStatus.tr(),
          textStyle: AppTextStyles.xs13Bold,
          isEnabled: true,
          onPressed: null,
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: _contentPadding,
              sliver: SliverMainAxisGroup(
                slivers: [
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(bottom: AppSpacing.l16),
                      child: BrokerSubmissionHero(
                        titleKey: AppLocaleKey.villageRequestsSubmitted,
                        subtitleKey: AppLocaleKey.villageRequestsSubmittedDescription,
                        showLogo: false,
                      ),
                    ),
                  ),
                  SliverList.separated(
                    itemCount: villages.length,
                    separatorBuilder: (_, _) => AppSpacing.gapV10,
                    itemBuilder: (context, index) {
                      final village = villages[index];
                      return BrokerVillageRequestCard(key: ValueKey(village.id), village: village);
                    },
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(top: AppSpacing.xxl24),
                      child: BrokerVillageRequestsSummaryCard(requestCount: villages.length),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
