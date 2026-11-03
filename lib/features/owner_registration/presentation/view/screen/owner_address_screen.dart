import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../widget/owner_address_actions.dart';
import '../widget/owner_address_form.dart';
import '../widget/registration_form_layout.dart';

class OwnerAddressScreen extends StatelessWidget {
  const OwnerAddressScreen({super.key});

  static const _step = 3;
  static const _stepCount = 8;
  static const _progress = 0.375;
  static const _introGap = 24.0;

  @override
  Widget build(BuildContext context) {
    return RegistrationFormLayout(
      stepLabel: AppLocaleKey.stepXOfY.tr(args: ['$_step', '$_stepCount']),
      progress: _progress,
      eyebrow: AppLocaleKey.officialAddress.tr(),
      title: AppLocaleKey.ownerAddressTitle.tr(),
      subtitle: AppLocaleKey.addOfficialAddressDescription.tr(),
      form: const OwnerAddressForm(),
      actions: const OwnerAddressActions(),
      introGap: _introGap,
    );
  }
}
