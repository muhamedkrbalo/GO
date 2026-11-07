import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../widget/owner_registration_step_header.dart';
import '../widget/ownership_details_bottom_bar.dart';
import '../widget/ownership_details_form.dart';
import '../widget/registration_intro.dart';
import '../widget/unit_info_strip.dart';
import '../widget/unit_tabs_card.dart';

class OwnershipDetailsScreen extends StatelessWidget {
  const OwnershipDetailsScreen({super.key});

  static const _step = 6;
  static const _stepCount = 8;
  static const _progress = 0.75;
  static const _contentPadding = EdgeInsetsDirectional.fromSTEB(20, 24, 20, 28);
  static const _formGap = SizedBox(height: 22);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.customColors.canvas,
      bottomNavigationBar: const OwnershipDetailsBottomBar(),
      body: Column(
        children: [
          OwnerRegistrationStepHeader(
            stepLabel: AppLocaleKey.stepXOfY.tr(args: ['$_step', '$_stepCount']),
            progress: _progress,
          ),
          Expanded(
            child: ListView(
              padding: _contentPadding,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: [
                RegistrationIntro(
                  eyebrow: AppLocaleKey.perUnitDetails.tr(),
                  title: AppLocaleKey.ownershipInformation.tr(),
                  subtitle: AppLocaleKey.ownershipInformationDescription.tr(),
                ),
                AppSpacing.gapV20,
                const UnitTabsCard(),
                AppSpacing.gapV12,
                const UnitInfoStrip(),
                _formGap,
                const OwnershipDetailsForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
