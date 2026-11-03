import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/custom_widgets/buttons/primary_arrow_button.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../data/model/business_role.dart';
import '../../controller/business_role_cubit.dart';

class BusinessRoleContinueButton extends StatelessWidget {
  const BusinessRoleContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusinessRoleCubit, BusinessRole?>(
      builder: (context, selected) => PrimaryArrowButton(
        text: AppLocaleKey.continue_.tr(),
        isEnabled: selected != null,
        onPressed: selected == BusinessRole.owner
            ? () => context.pushNamed(RouteNames.ownerType)
            : null,
      ),
    );
  }
}
