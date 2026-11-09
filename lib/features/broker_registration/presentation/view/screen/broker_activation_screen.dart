import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/buttons/primary_arrow_button.dart';
import '../../../../../core/custom_widgets/registration_form/registration_intro.dart';
import '../../../../../core/custom_widgets/registration_form/registration_sticky_footer.dart';
import '../../../../../core/custom_widgets/registration_step_header/registration_step_header.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/broker_activation_checklist.dart';
import '../widget/broker_activation_requirements_card.dart';
import '../widget/broker_activation_status_banner.dart';

class BrokerActivationScreen extends StatelessWidget {
  const BrokerActivationScreen({super.key, required this.checklist});

  final BrokerActivationChecklist checklist;

  static const _contentPadding = EdgeInsetsDirectional.fromSTEB(22, 28, 22, 34);
  static const _introToBannerGap = SizedBox(height: 22);

  @override
  Widget build(BuildContext context) {
    final isActive = checklist.isActive;

    return Scaffold(
      backgroundColor: context.customColors.canvas,
      bottomNavigationBar: RegistrationStickyFooter(
        showSaveAndExit: false,
        child: PrimaryArrowButton(
          text: AppLocaleKey.goToBrokerDashboard.tr(),
          textStyle: AppTextStyles.xs13Bold,
          isEnabled: isActive,
          onPressed: null,
        ),
      ),
      body: Column(
        children: [
          RegistrationStepHeader(title: AppLocaleKey.brokerActivation.tr()),
          Expanded(
            child: ListView(
              padding: _contentPadding,
              children: [
                RegistrationIntro(
                  eyebrow: AppLocaleKey.activationRequirements.tr(),
                  title: AppLocaleKey.yourBrokerAccount.tr(),
                  subtitle: AppLocaleKey.reviewActivationConditions.tr(),
                ),
                _introToBannerGap,
                BrokerActivationStatusBanner(isActive: isActive),
                AppSpacing.gapV15,
                BrokerActivationRequirementsCard(checklist: checklist),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
