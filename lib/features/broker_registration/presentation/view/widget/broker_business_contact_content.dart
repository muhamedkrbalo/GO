import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/registration_form/registration_notice.dart';
import '../../../../../core/locale/app_locale_key.dart';
import 'business_contact_card.dart';

class BrokerBusinessContactContent extends StatelessWidget {
  const BrokerBusinessContactContent({super.key});

  static const _gap = SizedBox(height: 16);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const BusinessContactCard(),
        _gap,
        RegistrationNotice(message: AppLocaleKey.businessContactsSeparateNote.tr()),
      ],
    );
  }
}
