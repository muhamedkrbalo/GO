import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../controller/broker_registration_draft_cubit.dart';
import '../widget/broker_business_contact_content.dart';
import '../widget/broker_business_contact_footer.dart';
import '../widget/broker_form_layout.dart';

class BrokerBusinessContactScreen extends StatelessWidget {
  const BrokerBusinessContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BrokerFormLayout(
      step: context.select<BrokerRegistrationDraftCubit, int>(
        (cubit) => cubit.state.businessContactStep,
      ),
      eyebrow: AppLocaleKey.officialCommunication.tr(),
      title: AppLocaleKey.businessContactInformation.tr(),
      subtitle: AppLocaleKey.addOfficialContactDetails.tr(),
      form: const BrokerBusinessContactContent(),
      footer: const BrokerBusinessContactFooter(),
    );
  }
}
