import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/extension/context_ui_extension.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../../../core/utils/document_picker_methods.dart';
import '../../../data/model/owner_document.dart';
import '../../controller/owner_documents_cubit.dart';
import 'status_pill.dart';
import 'upload_dropzone.dart';
import 'uploaded_document_tile.dart';

class DocumentUploadCard extends StatelessWidget {
  const DocumentUploadCard({super.key, required this.slot});

  final DocumentSlot slot;

  static const _padding = EdgeInsets.all(14.4);
  static const _radius = BorderRadius.all(Radius.circular(12));
  static const _borderWidth = 1.6;
  static const _hintGap = SizedBox(height: 6);

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
        border: Border.all(color: colors.subtleBorder, width: _borderWidth),
        boxShadow: AppShadows.softCard,
      ),
      child: Padding(
        padding: _padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              spacing: AppSpacing.s8,
              runSpacing: AppSpacing.xs5,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  type.titleKey.tr(),
                  style: AppTextStyles.xxsBold.copyWith(color: colors.textSecondary),
                ),
                StatusPill(
                  label: type.isRequired
                      ? AppLocaleKey.requiredBadge.tr()
                      : AppLocaleKey.optional.tr(),
                  tone: type.isRequired ? StatusPillTone.warning : StatusPillTone.neutral,
                ),
              ],
            ),
            AppSpacing.gapV12,
            BlocSelector<OwnerDocumentsCubit, OwnerDocumentsState, UploadedDocument?>(
              selector: (state) => state.documentOf(slot),
              builder: (context, document) => document == null
                  ? UploadDropzone(onTap: () => _pick(context))
                  : UploadedDocumentTile(
                      document: document,
                      onRemove: () => context.read<OwnerDocumentsCubit>().remove(slot),
                    ),
            ),
            _hintGap,
            Text(
              AppLocaleKey.documentFormatsHint.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.xxxsRegular.copyWith(color: colors.textMuted),
            ),
          ],
        ),
      ),
    );
  }
}
