import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/custom_widgets/buttons/primary_arrow_button.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../data/model/owner_type.dart';
import '../../controller/owner_registration_draft_cubit.dart';
import '../../controller/owner_type_cubit.dart';

class OwnerTypeContinueButton extends StatelessWidget {
  const OwnerTypeContinueButton({super.key});

  void _continue(BuildContext context, OwnerType type) {
    context.read<OwnerRegistrationDraftCubit>().startRegistration(type);
    context.pushNamed(switch (type) {
      OwnerType.individual => RouteNames.individualInfo,
      OwnerType.company => RouteNames.companyInfo,
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnerTypeCubit, OwnerType?>(
      builder: (context, selected) => PrimaryArrowButton(
        text: AppLocaleKey.continue_.tr(),
        isEnabled: selected != null,
        onPressed: selected == null ? null : () => _continue(context, selected),
      ),
    );
  }
}
