import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/owner_documents_cubit.dart';
import '../widget/document_section_header.dart';
import '../widget/document_upload_card.dart';
import '../widget/owner_documents_bottom_bar.dart';
import '../widget/owner_documents_intro.dart';
import '../widget/registration_progress_header.dart';
import '../widget/review_notice.dart';
import '../widget/unit_documents_card.dart';

class OwnerDocumentsScreen extends StatelessWidget {
  const OwnerDocumentsScreen({super.key});

  static const _step = 6;
  static const _progress = 0.9;
  static const _ownerPadding = EdgeInsets.fromLTRB(20, 24, 20, 0);
  static const _unitsPadding = EdgeInsets.symmetric(horizontal: 20);
  static const _noticePadding = EdgeInsets.fromLTRB(20, 16, 20, 24);
  static const _sectionDividerPadding = EdgeInsets.only(top: 26, bottom: 22);
  static const _dividerThickness = 1.6;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final units = context.read<OwnerDocumentsCubit>().state.units;

    return Scaffold(
      backgroundColor: colors.canvas,
      bottomNavigationBar: const OwnerDocumentsBottomBar(),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            RegistrationProgressHeader(
              step: _step,
              progress: _progress,
              completedLabel: AppLocaleKey.ownershipDetailsComplete.tr(),
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: _ownerPadding,
                    sliver: SliverList.list(
                      children: [
                        const OwnerDocumentsIntro(),
                        AppSpacing.gapV20,
                        DocumentSectionHeader(
                          number: 1,
                          title: AppLocaleKey.ownerDocuments.tr(),
                          subtitle: AppLocaleKey.ownerDocumentsDescription.tr(),
                        ),
                        AppSpacing.gapV12,
                        const DocumentUploadCard(slot: OwnerDocumentsState.identitySlot),
                        AppSpacing.gapV10,
                        const DocumentUploadCard(slot: OwnerDocumentsState.supportingSlot),
                        Padding(
                          padding: _sectionDividerPadding,
                          child: Divider(
                            height: _dividerThickness,
                            thickness: _dividerThickness,
                            color: colors.subtleBorder,
                          ),
                        ),
                        DocumentSectionHeader(
                          number: 2,
                          title: AppLocaleKey.unitOwnershipDocuments.tr(),
                          subtitle: AppLocaleKey.unitOwnershipDocumentsDescription.tr(),
                        ),
                        AppSpacing.gapV12,
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: _unitsPadding,
                    sliver: SliverList.separated(
                      itemCount: units.length,
                      separatorBuilder: (_, _) => AppSpacing.gapV10,
                      itemBuilder: (context, index) => UnitDocumentsCard(
                        key: ValueKey(units[index].id),
                        unit: units[index],
                        initiallyExpanded: index == 0,
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: _noticePadding,
                    sliver: SliverToBoxAdapter(
                      child: ReviewNotice(
                        icon: AppImages.assetsSvgShieldAlert,
                        message: AppLocaleKey.documentsReviewNotice.tr(),
                      ),
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
