import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../widget/broker_form_layout.dart';
import '../widget/broker_identity_info_footer.dart';
import '../widget/broker_identity_info_form.dart';

class BrokerIdentityInfoScreen extends StatelessWidget {
  const BrokerIdentityInfoScreen({super.key});

  static const _step = 3;

  @override
  Widget build(BuildContext context) {
    return BrokerFormLayout(
      step: _step,
      eyebrow: AppLocaleKey.identityVerification.tr(),
      title: AppLocaleKey.identityInformation.tr(),
      subtitle: AppLocaleKey.provideIdentityDetails.tr(),
      form: const BrokerIdentityInfoForm(),
      footer: const BrokerIdentityInfoFooter(),
    );
  }
}
