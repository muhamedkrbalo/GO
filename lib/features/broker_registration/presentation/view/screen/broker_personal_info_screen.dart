import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../widget/broker_form_layout.dart';
import '../widget/broker_personal_info_footer.dart';
import '../widget/broker_personal_info_form.dart';

class BrokerPersonalInfoScreen extends StatelessWidget {
  const BrokerPersonalInfoScreen({super.key});

  static const _step = 2;

  @override
  Widget build(BuildContext context) {
    return BrokerFormLayout(
      step: _step,
      eyebrow: AppLocaleKey.individualBroker.tr(),
      title: AppLocaleKey.personalInformation.tr(),
      subtitle: AppLocaleKey.tellUsAboutIndividualBroker.tr(),
      form: const BrokerPersonalInfoForm(),
      footer: const BrokerPersonalInfoFooter(),
    );
  }
}
