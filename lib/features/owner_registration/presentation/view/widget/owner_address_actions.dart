import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/routes_name.dart';
import '../../controller/owner_address_cubit.dart';
import '../../controller/owner_registration_draft_cubit.dart';
import 'registration_form_actions.dart';

class OwnerAddressActions extends StatelessWidget {
  const OwnerAddressActions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<OwnerAddressCubit, OwnerAddressState, bool>(
      selector: (state) => state.canContinue,
      builder: (context, canContinue) => RegistrationFormActions(
        canContinue: canContinue,
        onContinue: () {
          context.read<OwnerRegistrationDraftCubit>().saveAddress(
            context.read<OwnerAddressCubit>().state,
          );
          context.pushNamed(RouteNames.unitSelection);
        },
      ),
    );
  }
}
