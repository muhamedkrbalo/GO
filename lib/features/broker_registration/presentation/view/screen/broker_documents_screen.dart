import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../widget/broker_documents_footer.dart';
import '../widget/broker_documents_list.dart';
import '../widget/broker_form_layout.dart';

class BrokerDocumentsScreen extends StatelessWidget {
  const BrokerDocumentsScreen({super.key});

  static const _step = 7;

  @override
  Widget build(BuildContext context) {
    return BrokerFormLayout(
      step: _step,
      eyebrow: AppLocaleKey.verificationFiles.tr(),
      title: AppLocaleKey.requiredDocuments.tr(),
      subtitle: AppLocaleKey.uploadBrokerDocuments.tr(),
      form: const BrokerDocumentsList(),
      footer: const BrokerDocumentsFooter(),
    );
  }
}
