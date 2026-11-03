import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../widget/individual_info_actions.dart';
import '../widget/individual_info_form.dart';
import '../widget/owner_registration_step_header.dart';
import '../widget/registration_intro.dart';

class IndividualInfoScreen extends StatelessWidget {
  const IndividualInfoScreen({super.key});

  static const _step = 2;
  static const _stepCount = 8;
  static const _progress = 0.25;
  static const _contentPadding = EdgeInsetsDirectional.fromSTEB(24, 30, 24, 40);
  static const _sectionGap = SizedBox(height: 30);

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Form(
      child: Scaffold(
        backgroundColor: colors.canvas,
        body: Column(
          children: [
            OwnerRegistrationStepHeader(
              stepLabel: AppLocaleKey.stepXOfY.tr(args: ['$_step', '$_stepCount']),
              progress: _progress,
            ),
            Expanded(
              child: SafeArea(
                top: false,
                child: ListView(
                  padding: _contentPadding,
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  children: [
                    RegistrationIntro(
                      eyebrow: AppLocaleKey.individualOwner.tr(),
                      title: AppLocaleKey.individualOwnerInformation.tr(),
                      subtitle: AppLocaleKey.enterOwnerLegalInformation.tr(),
                    ),
                    _sectionGap,
                    const IndividualInfoForm(),
                    _sectionGap,
                    const IndividualInfoActions(),
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
