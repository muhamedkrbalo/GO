import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../widget/owner_address_form.dart';
import '../widget/registration_step_layout.dart';

class OwnerAddressScreen extends StatelessWidget {
  const OwnerAddressScreen({super.key});

  static const _step = 3;
  static const _progress = 0.5;

  @override
  Widget build(BuildContext context) {
    return RegistrationStepLayout(
      step: _step,
      progress: _progress,
      completedLabel: AppLocaleKey.ownerDetailsComplete.tr(),
      eyebrow: AppLocaleKey.businessEntityAddress.tr(),
      title: AppLocaleKey.whereAreYouBased.tr(),
      subtitle: AppLocaleKey.addAddressDetails.tr(),
      onContinue: () => context.pushNamed(RouteNames.unitSelection),
      child: const OwnerAddressForm(),
    );
  }
}
