import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/routes_name.dart';
import '../../controller/broker_business_address_cubit.dart';
import '../../controller/broker_registration_draft_cubit.dart';
import 'broker_form_footer.dart';

class BrokerBusinessAddressFooter extends StatelessWidget {
  const BrokerBusinessAddressFooter({super.key});

  void _continue(BuildContext context) {
    // Form.of(context).validate();
    context.read<BrokerRegistrationDraftCubit>().saveBusinessAddress(
      context.read<BrokerBusinessAddressCubit>().state,
    );
    context.pushNamed(RouteNames.brokerBusinessContact);
  }

  @override
  Widget build(BuildContext context) {
    return BrokerFormFooter(isEnabled: true, onContinue: () => _continue(context));
  }
}
