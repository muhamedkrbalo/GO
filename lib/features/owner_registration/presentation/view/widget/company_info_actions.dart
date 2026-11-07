import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/routes_name.dart';
import '../../controller/company_info_cubit.dart';
import '../../controller/owner_registration_draft_cubit.dart';
import 'registration_form_actions.dart';

class CompanyInfoActions extends StatelessWidget {
  const CompanyInfoActions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CompanyInfoCubit, CompanyInfoState, bool>(
      selector: (state) => state.canContinue,
      builder: (context, canContinue) => RegistrationFormActions(
        canContinue: canContinue,
        onContinue: () {
          context.read<OwnerRegistrationDraftCubit>().saveCompany(
            context.read<CompanyInfoCubit>().state,
          );
          context.pushNamed(RouteNames.ownerAddress);
        },
      ),
    );
  }
}
