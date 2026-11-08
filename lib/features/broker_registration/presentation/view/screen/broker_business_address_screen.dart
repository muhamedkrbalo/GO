import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../controller/broker_registration_draft_cubit.dart';
import '../widget/broker_business_address_footer.dart';
import '../widget/broker_business_address_form.dart';
import '../widget/broker_form_layout.dart';

class BrokerBusinessAddressScreen extends StatelessWidget {
  const BrokerBusinessAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BrokerFormLayout(
      step: context.select<BrokerRegistrationDraftCubit, int>(
        (cubit) => cubit.state.businessAddressStep,
      ),
      eyebrow: AppLocaleKey.businessLocation.tr(),
      title: AppLocaleKey.businessAddressTitle.tr(),
      subtitle: AppLocaleKey.addBrokerOfficialAddress.tr(),
      form: const BrokerBusinessAddressForm(),
      footer: const BrokerBusinessAddressFooter(),
    );
  }
}
