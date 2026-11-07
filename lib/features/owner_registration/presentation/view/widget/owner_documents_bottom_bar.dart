import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/buttons/primary_arrow_button.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../controller/owner_documents_cubit.dart';
import 'registration_sticky_footer.dart';

class OwnerDocumentsBottomBar extends StatelessWidget {
  const OwnerDocumentsBottomBar({super.key, this.onContinue});

  final VoidCallback? onContinue;

  @override
  Widget build(BuildContext context) {
    return RegistrationStickyFooter(
      child: BlocSelector<OwnerDocumentsCubit, OwnerDocumentsState, bool>(
        selector: (state) => state.isComplete,
        builder: (context, isComplete) => PrimaryArrowButton(
          text: AppLocaleKey.continue_.tr(),
        //  isEnabled: isComplete,
        isEnabled: true,
          onPressed: onContinue,
        ),
      ),
    );
  }
}
