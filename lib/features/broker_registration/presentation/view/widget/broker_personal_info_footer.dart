import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/routes_name.dart';
import '../../controller/broker_personal_info_cubit.dart';
import 'broker_form_footer.dart';

class BrokerPersonalInfoFooter extends StatelessWidget {
  const BrokerPersonalInfoFooter({super.key});

  void _continue(BuildContext context) {
    // if (!Form.of(context).validate()) return;
    context.pushNamed(RouteNames.brokerIdentityInfo);
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<BrokerPersonalInfoCubit, BrokerPersonalInfoState, bool>(
      selector: (state) => state.canContinue,
      builder: (context, canContinue) => BrokerFormFooter(
        //isEnabled: canContinue,
        isEnabled: true,
        onContinue:()=>_continue(context),
     //   onContinue: canContinue ? () => _continue(context) : null,
      ),
    );
  }
}
