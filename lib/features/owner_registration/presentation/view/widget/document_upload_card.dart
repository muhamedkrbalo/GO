import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/document_upload/upload_dropzone.dart';
import '../../../../../core/custom_widgets/document_upload/uploaded_document_tile.dart';
import '../../../../../core/extension/context_ui_extension.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../../../core/utils/document_picker_methods.dart';
import '../../../data/model/owner_document.dart';
import '../../controller/owner_documents_cubit.dart';

class DocumentUploadCard extends StatelessWidget {
  const DocumentUploadCard({super.key, required this.slot});

  final DocumentSlot slot;

  static const _padding = EdgeInsetsDirectional.all(14);
  static const _radius = BorderRadius.all(Radius.circular(13));
  static const _badgeGap = 7.0;
  static const _textHeight = 1.35;

  Future<void> _pick(BuildContext context) async {
    final cubit = context.read<OwnerDocumentsCubit>();
    final file = await DocumentPickerMethods.pickDocument();
    if (file == null) return;
    if (file.sizeInBytes > DocumentPickerMethods.maxSizeInBytes) {
      if (context.mounted) context.showErrorToast(message: AppLocaleKey.documentTooLarge.tr());
      return;
    }
    cubit.attach(
      slot,
      UploadedDocument(name: file.name, sizeInBytes: file.sizeInBytes, path: file.path),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final type = slot.type;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: _radius,
        border: Border.all(color: colors.subtleBorder),
        boxShadow: AppShadows.sectionCard,
      ),
      child: Padding(
        padding: _padding,
        child: BlocSelector<OwnerDocumentsCubit, OwnerDocumentsState, UploadedDocument?>(
          selector: (state) => state.documentOf(slot),
          builder: (context, document) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: _badgeGap,
                      runSpacing: AppSpacing.xs5,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          type.titleKey.tr(),
                          style: AppTextStyles.xxxsBold.copyWith(
                            color: colors.textSecondary,
                            height: _textHeight,
                          ),
                        ),
                        _RequirementBadge(isRequired: type.isRequired),
                      ],
                    ),
                  ),
                  AppSpacing.gapH8,
                  Text(
                    document == null ? AppLocaleKey.missing.tr() : AppLocaleKey.uploaded.tr(),
                    style: AppTextStyles.xxxxxsMedium.copyWith(
                      color: document == null ? colors.textMuted : colors.success,
                      fontWeight: FontWeight.w700,
                      height: _textHeight,
                    ),
                  ),
                ],
              ),
              AppSpacing.gapV12,
              if (document == null)
                UploadDropzone(onTap: () => _pick(context))
              else
                UploadedDocumentTile(
                  document: document,
                  onRemove: () => context.read<OwnerDocumentsCubit>().remove(slot),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RequirementBadge extends StatelessWidget {
  const _RequirementBadge({required this.isRequired});

  final bool isRequired;

  static const _padding = EdgeInsetsDirectional.symmetric(horizontal: 5, vertical: 3);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isRequired ? colors.goldSurface : colors.primaryLight,
        borderRadius: AppRadius.brCircle,
      ),
      child: Padding(
        padding: _padding,
        child: Text(
          isRequired ? AppLocaleKey.requiredBadge.tr() : AppLocaleKey.optional.tr(),
          style: AppTextStyles.xxxxxsMedium.copyWith(
            color: isRequired ? colors.goldLink : colors.textMuted,
            fontWeight: FontWeight.w700,
            height: _textHeight,
          ),
        ),
      ),
    );
  }
}
