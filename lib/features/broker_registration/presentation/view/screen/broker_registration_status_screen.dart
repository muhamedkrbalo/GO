import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/registration_form/registration_intro.dart';
import '../../../../../core/custom_widgets/registration_step_header/registration_step_header.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../widget/broker_status_card.dart';
import '../widget/broker_status_preview_controls.dart';

class BrokerRegistrationStatusScreen extends StatelessWidget {
  const BrokerRegistrationStatusScreen({super.key});

  static const _contentPadding = EdgeInsetsDirectional.fromSTEB(22, 28, 22, 34);
  static const _cardGap = SizedBox(height: 24);
  static const _controlsGap = SizedBox(height: 16);

  @override
  Widget build(BuildContext context) {
    final title = AppLocaleKey.brokerRegistrationStatus.tr();

    return Scaffold(
      backgroundColor: context.customColors.canvas,
      body: Column(
        children: [
          RegistrationStepHeader(title: title),
          Expanded(
            child: SafeArea(
              top: false,
              child: ListView(
                padding: _contentPadding,
                children: [
                  RegistrationIntro(
                    eyebrow: AppLocaleKey.registrationReview.tr(),
                    title: title,
                    subtitle: AppLocaleKey.trackBrokerRegistration.tr(),
                  ),
                  _cardGap,
                  const BrokerStatusCard(),
                  _controlsGap,
                  const BrokerStatusPreviewControls(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
