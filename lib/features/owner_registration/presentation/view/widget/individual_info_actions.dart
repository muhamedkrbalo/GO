import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/routes_name.dart';
import '../../controller/individual_info_cubit.dart';
import 'registration_form_actions.dart';

class IndividualInfoActions extends StatelessWidget {
  const IndividualInfoActions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<IndividualInfoCubit, IndividualInfoState, bool>(
      selector: (state) => state.canContinue,
      builder: (context, canContinue) => RegistrationFormActions(
        canContinue: canContinue,
        onContinue: () => context.pushNamed(RouteNames.ownerAddress),
      ),
    );
  }
}
