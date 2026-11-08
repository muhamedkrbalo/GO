import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../widget/broker_business_contact_content.dart';
import '../widget/broker_form_footer.dart';
import '../widget/broker_form_layout.dart';

class BrokerBusinessContactScreen extends StatelessWidget {
  const BrokerBusinessContactScreen({super.key});

  static const _step = 5;

  @override
  Widget build(BuildContext context) {
    return BrokerFormLayout(
      step: _step,
      eyebrow: AppLocaleKey.officialCommunication.tr(),
      title: AppLocaleKey.businessContactInformation.tr(),
      subtitle: AppLocaleKey.addOfficialContactDetails.tr(),
      form: const BrokerBusinessContactContent(),
      footer: const BrokerFormFooter(isEnabled: true, onContinue: null),
    );
  }
}
