import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../widget/broker_form_layout.dart';
import '../widget/broker_representative_footer.dart';
import '../widget/broker_representative_form.dart';

class BrokerRepresentativeScreen extends StatelessWidget {
  const BrokerRepresentativeScreen({super.key});

  static const _step = 4;
  static const _introToNoticeGap = 16.0;

  @override
  Widget build(BuildContext context) {
    return BrokerFormLayout(
      step: _step,
      eyebrow: AppLocaleKey.companyAuthorization.tr(),
      title: AppLocaleKey.authorizedRepresentative.tr(),
      subtitle: AppLocaleKey.addAuthorizedRepresentative.tr(),
      introToFormGap: _introToNoticeGap,
      form: const BrokerRepresentativeForm(),
      footer: const BrokerRepresentativeFooter(),
    );
  }
}
