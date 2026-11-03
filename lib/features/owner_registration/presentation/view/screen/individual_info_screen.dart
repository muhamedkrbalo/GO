import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../widget/individual_info_actions.dart';
import '../widget/individual_info_form.dart';
import '../widget/registration_form_layout.dart';

class IndividualInfoScreen extends StatelessWidget {
  const IndividualInfoScreen({super.key});

  static const _step = 2;
  static const _stepCount = 8;
  static const _progress = 0.25;

  @override
  Widget build(BuildContext context) {
    return RegistrationFormLayout(
      stepLabel: AppLocaleKey.stepXOfY.tr(args: ['$_step', '$_stepCount']),
      progress: _progress,
      eyebrow: AppLocaleKey.individualOwner.tr(),
      title: AppLocaleKey.individualOwnerInformation.tr(),
      subtitle: AppLocaleKey.enterOwnerLegalInformation.tr(),
      form: const IndividualInfoForm(),
      actions: const IndividualInfoActions(),
    );
  }
}
