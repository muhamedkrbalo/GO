import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/registration_form/registration_intro.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import 'owner_registration_step_header.dart';

class RegistrationFormLayout extends StatelessWidget {
  const RegistrationFormLayout({
    super.key,
    required this.stepLabel,
    required this.progress,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.form,
    required this.actions,
    this.introGap = 30,
  });

  final String stepLabel;
  final double progress;
  final String eyebrow;
  final String title;
  final String subtitle;
  final Widget form;
  final Widget actions;
  final double introGap;

  static const _contentPadding = EdgeInsetsDirectional.fromSTEB(24, 30, 24, 40);
  static const _sectionGap = SizedBox(height: 30);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        backgroundColor: context.customColors.canvas,
        body: Column(
          children: [
            OwnerRegistrationStepHeader(stepLabel: stepLabel, progress: progress),
            Expanded(
              child: SafeArea(
                top: false,
                child: ListView(
                  padding: _contentPadding,
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  children: [
                    RegistrationIntro(eyebrow: eyebrow, title: title, subtitle: subtitle),
                    SizedBox(height: introGap),
                    form,
                    _sectionGap,
                    actions,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
