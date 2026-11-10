import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/buttons/primary_arrow_button.dart';
import '../../../../../core/custom_widgets/registration_form/registration_sticky_footer.dart';
import '../../../data/model/owner_package.dart';
import '../../controller/owner_packages_cubit.dart';

class OwnerPackagesBottomBar extends StatelessWidget {
  const OwnerPackagesBottomBar({super.key, required this.label, required this.onContinue});

  final String label;
  final ValueChanged<OwnerPackage> onContinue;

  void _continue(BuildContext context) {
    final package = context.read<OwnerPackagesCubit>().state.selectedPackage;
    if (package != null) onContinue(package);
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
          onPressed: () => _continue(context),
        ),
      ),
    );
  }
}
