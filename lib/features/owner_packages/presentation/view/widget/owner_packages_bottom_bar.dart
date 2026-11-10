import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/custom_widgets/buttons/primary_arrow_button.dart';
import '../../../../../core/custom_widgets/registration_form/registration_sticky_footer.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../controller/owner_packages_cubit.dart';

class OwnerPackagesBottomBar extends StatelessWidget {
  const OwnerPackagesBottomBar({super.key, required this.label});

  final String label;

  void _openConfirmation(BuildContext context) {
    final package = context.read<OwnerPackagesCubit>().state.selectedPackage;
    if (package == null) return;
    context.pushNamed(RouteNames.ownerPackageConfirmation, extra: package);
  }

  @override
  Widget build(BuildContext context) {
    return RegistrationStickyFooter(
      showSaveAndExit: false,
      child: BlocSelector<OwnerPackagesCubit, OwnerPackagesState, bool>(
        selector: (state) => state.canContinue,
        builder: (context, canContinue) => PrimaryArrowButton(
          text: label,
          isEnabled: canContinue,
          onPressed: () => _openConfirmation(context),
        ),
      ),
    );
  }
}
