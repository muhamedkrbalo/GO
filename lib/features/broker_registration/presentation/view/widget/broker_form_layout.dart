import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/registration_form/registration_intro.dart';
import '../../../../../core/custom_widgets/registration_step_header/registration_step_header.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class BrokerFormLayout extends StatelessWidget {
  const BrokerFormLayout({
    super.key,
    required this.step,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.form,
    required this.footer,
    this.introToFormGap = 28,
  });

  final int step;
  final String eyebrow;
  final String title;
  final String subtitle;
  final Widget form;
  final Widget footer;
  final double introToFormGap;

  static const totalSteps = 8;
  static const _contentPadding = EdgeInsetsDirectional.fromSTEB(22, 28, 22, 34);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        backgroundColor: context.customColors.canvas,
        bottomNavigationBar: footer,
        body: Column(
          children: [
            RegistrationStepHeader(
              title: AppLocaleKey.brokerRegistration.tr(),
              stepLabel: AppLocaleKey.stepXOfY.tr(args: ['$step', '$totalSteps']),
              progress: step / totalSteps,
            ),
            Expanded(
              child: ListView(
                padding: _contentPadding,
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                children: [
                  RegistrationIntro(eyebrow: eyebrow, title: title, subtitle: subtitle),
                  SizedBox(height: introToFormGap),
                  form,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
