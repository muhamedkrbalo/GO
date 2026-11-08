import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/custom_widgets/buttons/primary_arrow_button.dart';
import '../../../../../core/custom_widgets/registration_form/registration_sticky_footer.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../controller/owner_documents_cubit.dart';
import '../../controller/owner_registration_draft_cubit.dart';

class OwnerDocumentsBottomBar extends StatelessWidget {
  const OwnerDocumentsBottomBar({super.key});

  void _continue(BuildContext context) {
    final documents = context.read<OwnerDocumentsCubit>().state.documents;
    context.read<OwnerRegistrationDraftCubit>().saveDocuments(documents);
    context.pushNamed(RouteNames.registrationReview);
  }

  @override
  Widget build(BuildContext context) {
    return RegistrationStickyFooter(
      child: BlocSelector<OwnerDocumentsCubit, OwnerDocumentsState, bool>(
        selector: (state) => state.isComplete,
        builder: (context, isComplete) => PrimaryArrowButton(
          text: AppLocaleKey.continue_.tr(),
          //  isEnabled: isComplete,
          isEnabled: true,
          onPressed: () => _continue(context),
        ),
      ),
    );
  }
}
