import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../widget/individual_info_form.dart';
import '../widget/registration_step_layout.dart';

class IndividualInfoScreen extends StatelessWidget {
  const IndividualInfoScreen({super.key});

  static const _step = 2;
  static const _progress = 0.25;

  @override
  Widget build(BuildContext context) {
    return RegistrationStepLayout(
      step: _step,
      progress: _progress,
      completedLabel: AppLocaleKey.ownerTypeSelected.tr(),
      eyebrow: AppLocaleKey.individualOwner.tr(),
      title: AppLocaleKey.yourPersonalInformation.tr(),
      subtitle: AppLocaleKey.enterLegalDetails.tr(),
      onContinue: () => context.pushNamed(RouteNames.ownerAddress),
      child: const IndividualInfoForm(),
    );
  }
}
