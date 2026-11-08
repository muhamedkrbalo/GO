import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../widget/broker_company_info_footer.dart';
import '../widget/broker_company_info_form.dart';
import '../widget/broker_form_layout.dart';

class BrokerCompanyInfoScreen extends StatelessWidget {
  const BrokerCompanyInfoScreen({super.key});

  static const _step = 2;

  @override
  Widget build(BuildContext context) {
    return BrokerFormLayout(
      step: _step,
      eyebrow: AppLocaleKey.companyBroker.tr(),
      title: AppLocaleKey.companyInformation.tr(),
      subtitle: AppLocaleKey.enterBrokerCompanyInformation.tr(),
      form: const BrokerCompanyInfoForm(),
      footer: const BrokerCompanyInfoFooter(),
    );
  }
}
