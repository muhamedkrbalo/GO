import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/routes_name.dart';
import '../../controller/broker_identity_info_cubit.dart';
import '../../controller/broker_registration_draft_cubit.dart';
import 'broker_form_footer.dart';

class BrokerIdentityInfoFooter extends StatelessWidget {
  const BrokerIdentityInfoFooter({super.key});

  void _continue(BuildContext context) {
    // Form.of(context).validate();
    context.read<BrokerRegistrationDraftCubit>().saveIdentityInfo(
      context.read<BrokerIdentityInfoCubit>().state,
    );
    context.pushNamed(RouteNames.brokerBusinessAddress);
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<BrokerIdentityInfoCubit, BrokerIdentityInfoState, bool>(
      selector: (state) => state.canContinue,
      builder: (context, canContinue) => BrokerFormFooter(
        //isEnabled: canContinue,
        isEnabled: true,
        onContinue: () => _continue(context),
        //onContinue: canContinue ? () => _continue(context) : null,
      ),
    );
  }
}
