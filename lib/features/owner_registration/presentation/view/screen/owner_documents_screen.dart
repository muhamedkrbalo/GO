import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/owner_document.dart';
import '../../controller/owner_documents_cubit.dart';
import '../widget/document_section_header.dart';
import '../widget/document_upload_card.dart';
import '../widget/documents_notice.dart';
import '../widget/documents_summary_strip.dart';
import '../widget/owner_documents_bottom_bar.dart';
import '../widget/owner_registration_step_header.dart';
import '../widget/registration_intro.dart';
import '../widget/unit_documents_card.dart';

class OwnerDocumentsScreen extends StatelessWidget {
  const OwnerDocumentsScreen({super.key});

  static const _step = 7;
  static const _stepCount = 8;
  static const _progress = 0.875;
  static const _contentPadding = EdgeInsetsDirectional.fromSTEB(20, 24, 20, 30);
  static const _sectionGap = SizedBox(height: 28);
  static const _headerGap = SizedBox(height: 13);
  static const _cardGap = SizedBox(height: 11);

  @override
  Widget build(BuildContext context) {
    final units = context.read<OwnerDocumentsCubit>().state.units;

    return Scaffold(
      backgroundColor: context.customColors.canvas,
      bottomNavigationBar: const OwnerDocumentsBottomBar(),
      body: Column(
        children: [
          OwnerRegistrationStepHeader(
            stepLabel: AppLocaleKey.stepXOfY.tr(args: ['$_step', '$_stepCount']),
            progress: _progress,
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: _contentPadding,
                  sliver: SliverMainAxisGroup(
                    slivers: [
                      SliverList.list(
                        children: [
                          RegistrationIntro(
                            eyebrow: AppLocaleKey.verificationFiles.tr(),
                            title: AppLocaleKey.uploadRequiredDocuments.tr(),
                            subtitle: AppLocaleKey.uploadDocumentsDescription.tr(),
                          ),
                          AppSpacing.gapV20,
                          const DocumentsSummaryStrip(),
                          _sectionGap,
                          DocumentSectionHeader(
                            number: 1,
                            title: AppLocaleKey.ownerDocuments.tr(),
                            subtitle: AppLocaleKey.ownerDocumentsDescription.tr(),
                          ),
                          _headerGap,
                          for (final type in DocumentType.ownerTypes) ...[
                            if (type != DocumentType.ownerTypes.first) _cardGap,
                            DocumentUploadCard(slot: DocumentSlot(type)),
                          ],
                          _sectionGap,
                          DocumentSectionHeader(
                            number: 2,
                            title: AppLocaleKey.unitOwnershipDocuments.tr(),
                            subtitle: AppLocaleKey.unitOwnershipDocumentsDescription.tr(),
                          ),
                          _headerGap,
                        ],
                      ),
                      SliverList.separated(
                        itemCount: units.length,
                        separatorBuilder: (_, _) => AppSpacing.gapV10,
                        itemBuilder: (context, index) => UnitDocumentsCard(
                          key: ValueKey(units[index].id),
                          unit: units[index],
                          initiallyExpanded: index == 0,
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(top: AppSpacing.xl20),
                          child: DocumentsNotice(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
