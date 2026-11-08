import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/routes_name.dart';
import '../../controller/broker_company_info_cubit.dart';
import '../../controller/broker_registration_draft_cubit.dart';
import 'broker_form_footer.dart';

class BrokerCompanyInfoFooter extends StatelessWidget {
  const BrokerCompanyInfoFooter({super.key});

  void _continue(BuildContext context) {
   // if (!Form.of(context).validate()) return;
    context.read<BrokerRegistrationDraftCubit>().saveCompanyInfo(
      context.read<BrokerCompanyInfoCubit>().state,
    );
    context.pushNamed(RouteNames.brokerIdentityInfo);
  }

  @override
  Widget build(BuildContext context) {
    return BrokerFormFooter(isEnabled: true, onContinue: () => _continue(context));
  }
}
