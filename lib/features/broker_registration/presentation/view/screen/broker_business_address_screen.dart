import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../widget/broker_business_address_footer.dart';
import '../widget/broker_business_address_form.dart';
import '../widget/broker_form_layout.dart';

class BrokerBusinessAddressScreen extends StatelessWidget {
  const BrokerBusinessAddressScreen({super.key});

  static const _step = 4;

  @override
  Widget build(BuildContext context) {
    return BrokerFormLayout(
      step: _step,
      eyebrow: AppLocaleKey.businessLocation.tr(),
      title: AppLocaleKey.businessAddressTitle.tr(),
      subtitle: AppLocaleKey.addBrokerOfficialAddress.tr(),
      form: const BrokerBusinessAddressForm(),
      footer: const BrokerBusinessAddressFooter(),
    );
  }
}
