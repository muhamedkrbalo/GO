import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/custom_widgets/buttons/primary_arrow_button.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../controller/selected_units_review_cubit.dart';
import 'registration_sticky_footer.dart';

class SelectedUnitsReviewBottomBar extends StatelessWidget {
  const SelectedUnitsReviewBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return RegistrationStickyFooter(
      child: BlocSelector<SelectedUnitsReviewCubit, SelectedUnitsReviewState, bool>(
        selector: (state) => state.canContinue,
        builder: (context, canContinue) => PrimaryArrowButton(
          text: AppLocaleKey.continue_.tr(),
          isEnabled: canContinue,
          onPressed: () => context.pushNamed(
            RouteNames.ownershipDetails,
            extra: context.read<SelectedUnitsReviewCubit>().state.units,
          ),
        ),
      ),
    );
  }
}
