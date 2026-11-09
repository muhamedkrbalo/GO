import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/custom_widgets/buttons/primary_arrow_button.dart';
import '../../../../../core/custom_widgets/registration_form/registration_intro.dart';
import '../../../../../core/custom_widgets/registration_form/registration_notice.dart';
import '../../../../../core/custom_widgets/registration_form/registration_sticky_footer.dart';
import '../../../../../core/custom_widgets/registration_step_header/registration_step_header.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/broker_village_assignment.dart';
import '../widget/broker_village_assignment_card.dart';

class BrokerVillageAssignmentsScreen extends StatelessWidget {
  const BrokerVillageAssignmentsScreen({super.key, required this.assignments});

  final List<BrokerVillageAssignment> assignments;

  static const _contentPadding = EdgeInsetsDirectional.fromSTEB(22, 28, 22, 34);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.customColors.canvas,
      bottomNavigationBar: RegistrationStickyFooter(
        showSaveAndExit: false,
        child: PrimaryArrowButton(
          text: AppLocaleKey.continueToActivation.tr(),
          textStyle: AppTextStyles.xs13Bold,
          isEnabled: true,
          onPressed: null,
        ),
      ),
      body: Column(
        children: [
          RegistrationStepHeader(title: AppLocaleKey.villageAssignment.tr()),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: _contentPadding,
                  sliver: SliverMainAxisGroup(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.l16),
                          child: RegistrationIntro(
                            eyebrow: AppLocaleKey.independentAssignments.tr(),
                            title: AppLocaleKey.myVillages.tr(),
                            subtitle: AppLocaleKey.trackVillageEndorsements.tr(),
                          ),
                        ),
                      ),
                      SliverList.separated(
                        itemCount: assignments.length,
                        separatorBuilder: (_, _) => AppSpacing.gapV10,
                        itemBuilder: (context, index) {
                          final assignment = assignments[index];
                          return BrokerVillageAssignmentCard(
                            key: ValueKey(assignment.village.id),
                            assignment: assignment,
                            onOpen: () => context.pushNamed(
                              RouteNames.brokerVillageEndorsement,
                              extra: assignment,
                            ),
                          );
                        },
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(top: AppSpacing.l16),
                          child: RegistrationNotice(
                            message: AppLocaleKey.inactiveVillagesNotice.tr(),
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
