import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/custom_widgets/registration_form/registration_intro.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/owner_type.dart';
import '../../controller/owner_registration_draft_cubit.dart';
import '../../controller/registration_review_cubit.dart';
import '../widget/documents_review.dart';
import '../widget/owner_address_review.dart';
import '../widget/owner_info_review.dart';
import '../widget/owner_registration_step_header.dart';
import '../widget/registration_confirmation_tile.dart';
import '../widget/registration_review_bottom_bar.dart';
import '../widget/review_section_card.dart';
import '../widget/selected_units_review.dart';
import '../widget/submission_check_card.dart';

class RegistrationReviewScreen extends StatelessWidget {
  const RegistrationReviewScreen({super.key});

  static const _progress = 1.0;
  static const _contentPadding = EdgeInsetsDirectional.fromSTEB(20, 24, 20, 30);
  static const _sectionGap = AppSpacing.gapV10;
  static const _checkGap = SizedBox(height: 22);
  static const _noteHeight = 1.5;

  static void _returnTo(BuildContext context, String routeName) {
    Navigator.of(context).popUntil((route) => route.settings.name == routeName || route.isFirst);
  }

  static void _openConfirmation(BuildContext context, RegistrationReviewState state) {
    final receipt = state.receipt;
    if (receipt == null) return;
    context.goNamed(RouteNames.registrationSubmitted, extra: receipt);
    context.read<OwnerRegistrationDraftCubit>().clear();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final review = context.read<RegistrationReviewCubit>().state;
    final draft = review.draft;
    final ownerRoute = draft.ownerType == OwnerType.company
        ? RouteNames.companyInfo
        : RouteNames.individualInfo;

    return BlocListener<RegistrationReviewCubit, RegistrationReviewState>(
      listenWhen: (previous, current) => previous.receipt == null && current.receipt != null,
      listener: _openConfirmation,
      child: Scaffold(
        backgroundColor: colors.canvas,
        bottomNavigationBar: const RegistrationReviewBottomBar(),
        body: Column(
          children: [
            OwnerRegistrationStepHeader(
              stepLabel: AppLocaleKey.finalStep.tr(),
              progress: _progress,
              progressColors: [colors.oceanAccent, colors.cyanAccent, colors.accentBar],
            ),
            Expanded(
              child: ListView(
                padding: _contentPadding,
                children: [
                  RegistrationIntro(
                    eyebrow: AppLocaleKey.reviewAndSubmit.tr(),
                    title: AppLocaleKey.reviewYourRegistration.tr(),
                    subtitle: AppLocaleKey.reviewYourRegistrationDescription.tr(),
                  ),
                  AppSpacing.gapV24,
                  ReviewSectionCard(
                    number: 1,
                    title: AppLocaleKey.ownerInformation.tr(),
                    onEdit: () => _returnTo(context, ownerRoute),
                    child: OwnerInfoReview(draft: draft),
                  ),
                  _sectionGap,
                  ReviewSectionCard(
                    number: 2,
                    title: AppLocaleKey.ownerAddress.tr(),
                    onEdit: () => _returnTo(context, RouteNames.ownerAddress),
                    child: OwnerAddressReview(address: draft.address),
                  ),
                  _sectionGap,
                  ReviewSectionCard(
                    number: 3,
                    title: AppLocaleKey.selectedUnits.tr(),
                    onEdit: () => _returnTo(context, RouteNames.unitSelection),
                    child: SelectedUnitsReview(units: draft.units, ownership: draft.ownership),
                  ),
                  _sectionGap,
                  ReviewSectionCard(
                    number: 4,
                    title: AppLocaleKey.documents.tr(),
                    onEdit: () => _returnTo(context, RouteNames.ownerDocuments),
                    child: DocumentsReview(units: draft.units, documents: draft.documents),
                  ),
                  _checkGap,
                  SubmissionCheckCard(review: review),
                  AppSpacing.gapV16,
                  const RegistrationConfirmationTile(),
                  AppSpacing.gapV12,
                  Text(
                    AppLocaleKey.submissionReviewNote.tr(),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.xxxxxsMedium.copyWith(
                      color: colors.hint,
                      fontWeight: FontWeight.w400,
                      height: _noteHeight,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
