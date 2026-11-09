import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/registration_form/registration_intro.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../widget/cant_find_unit_button.dart';
import '../widget/owner_registration_step_header.dart';
import '../widget/unit_filters.dart';
import '../widget/unit_list_header.dart';
import '../widget/unit_list_sliver.dart';
import '../widget/unit_selection_bottom_bar.dart';

class UnitSelectionScreen extends StatelessWidget {
  const UnitSelectionScreen({super.key});

  static const _step = 4;
  static const _stepCount = 8;
  static const _progress = 0.5;
  static const _contentPadding = EdgeInsetsDirectional.fromSTEB(20, 24, 20, 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.customColors.canvas,
      bottomNavigationBar: const UnitSelectionBottomBar(),
      body: Column(
        children: [
          OwnerRegistrationStepHeader(
            stepLabel: AppLocaleKey.stepXOfY.tr(args: ['$_step', '$_stepCount']),
            progress: _progress,
          ),
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
                            eyebrow: AppLocaleKey.propertyUnits.tr(),
                            title: AppLocaleKey.selectYourUnits.tr(),
                            subtitle: AppLocaleKey.selectUnitsDescription.tr(),
                          ),
                          AppSpacing.gapV20,
                          const UnitFilters(),
                          AppSpacing.gapV24,
                          const UnitListHeader(),
                          AppSpacing.gapV12,
                        ],
                      ),
                      const UnitListSliver(),
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(top: AppSpacing.s8),
                          child: CantFindUnitButton(),
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
