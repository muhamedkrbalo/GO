import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/document_upload/upload_dropzone.dart';
import '../../../../../core/custom_widgets/document_upload/uploaded_document_tile.dart';
import '../../../../../core/extension/context_ui_extension.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/models/uploaded_document.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../../../core/utils/document_picker_methods.dart';

class BrokerUploadCard extends StatelessWidget {
  const BrokerUploadCard({
    super.key,
    required this.title,
    required this.isRequired,
    required this.document,
    required this.onAttach,
    required this.onRemove,
  });

  final String title;
  final bool isRequired;
  final UploadedDocument? document;
  final ValueChanged<UploadedDocument> onAttach;
  final VoidCallback onRemove;

  static const _padding = EdgeInsetsDirectional.all(14);
  static const _radius = BorderRadius.all(Radius.circular(13));
  static const _titleToBodyGap = SizedBox(height: 12);
  static const _uploadIconSize = 25.0;
  static const _textHeight = 1.5;

  Future<void> _pick(BuildContext context) async {
    final file = await DocumentPickerMethods.pickDocument();
    if (file == null) return;
    if (file.sizeInBytes > DocumentPickerMethods.maxSizeInBytes) {
      if (context.mounted) context.showErrorToast(message: AppLocaleKey.documentTooLarge.tr());
      return;
    }
    onAttach(UploadedDocument(name: file.name, sizeInBytes: file.sizeInBytes, path: file.path));
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: _radius,
        border: Border.all(color: colors.subtleBorder),
      ),
      child: Padding(
        padding: _padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.xxxsBold.copyWith(
                      color: colors.textSecondary,
                      height: _textHeight,
                    ),
                  ),
                ),
                AppSpacing.gapH8,
                _RequirementBadge(isRequired: isRequired),
              ],
            ),
            _titleToBodyGap,
            if (document case final uploaded?)
              UploadedDocumentTile(document: uploaded, onRemove: onRemove)
            else
              UploadDropzone(
                showIconTile: false,
                iconSize: _uploadIconSize,
                onTap: () => _pick(context),
              ),
          ],
        ),
      ),
    );
  }
}

class _RequirementBadge extends StatelessWidget {
  const _RequirementBadge({required this.isRequired});

  final bool isRequired;

  static const _padding = EdgeInsetsDirectional.symmetric(horizontal: 6, vertical: 3);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(color: colors.goldSurface, borderRadius: AppRadius.brCircle),
      child: Padding(
        padding: _padding,
        child: Text(
          isRequired ? AppLocaleKey.requiredBadge.tr() : AppLocaleKey.optional.tr(),
          style: AppTextStyles.xxxxxsMedium.copyWith(
            color: colors.goldLink,
            fontWeight: FontWeight.w700,
            height: _textHeight,
          ),
        ),
      ),
    );
  }
}
