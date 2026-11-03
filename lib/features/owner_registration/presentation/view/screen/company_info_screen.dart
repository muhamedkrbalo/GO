import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../widget/company_info_actions.dart';
import '../widget/company_info_form.dart';
import '../widget/registration_form_layout.dart';

class CompanyInfoScreen extends StatelessWidget {
  const CompanyInfoScreen({super.key});

  static const _step = 2;
  static const _stepCount = 8;
  static const _progress = 0.25;

  @override
  Widget build(BuildContext context) {
    return RegistrationFormLayout(
      stepLabel: AppLocaleKey.stepXOfY.tr(args: ['$_step', '$_stepCount']),
      progress: _progress,
      eyebrow: AppLocaleKey.companyOwnerOption.tr(),
      title: AppLocaleKey.companyOwnerInformation.tr(),
      subtitle: AppLocaleKey.enterCompanyOfficialInformation.tr(),
      form: const CompanyInfoForm(),
      actions: const CompanyInfoActions(),
    );
  }
}
