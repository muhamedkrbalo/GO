import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/registration_form/registration_intro.dart';
import '../../../../../core/custom_widgets/registration_step_header/registration_step_header.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../widget/broker_personal_info_footer.dart';
import '../widget/broker_personal_info_form.dart';

class BrokerPersonalInfoScreen extends StatelessWidget {
  const BrokerPersonalInfoScreen({super.key});

  static const _step = 2;
  static const _totalSteps = 8;
  static const _contentPadding = EdgeInsetsDirectional.fromSTEB(22, 28, 22, 34);
  static const _introToFormGap = SizedBox(height: 28);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        backgroundColor: context.customColors.canvas,
        bottomNavigationBar: const BrokerPersonalInfoFooter(),
        body: Column(
          children: [
            RegistrationStepHeader(
              title: AppLocaleKey.brokerRegistration.tr(),
              stepLabel: AppLocaleKey.stepXOfY.tr(args: ['$_step', '$_totalSteps']),
              progress: _step / _totalSteps,
            ),
            Expanded(
              child: ListView(
                padding: _contentPadding,
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                children: [
                  RegistrationIntro(
                    eyebrow: AppLocaleKey.individualBroker.tr(),
                    title: AppLocaleKey.personalInformation.tr(),
                    subtitle: AppLocaleKey.tellUsAboutIndividualBroker.tr(),
                  ),
                  _introToFormGap,
                  const BrokerPersonalInfoForm(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
