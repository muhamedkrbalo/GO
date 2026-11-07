import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/owner_document.dart';

class SubmittedDocumentsList extends StatelessWidget {
  const SubmittedDocumentsList({super.key, required this.documents});

  final List<UploadedDocument> documents;

  static const _rowGap = SizedBox(height: 7);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    if (documents.isEmpty) {
      return Text(
        AppLocaleKey.noDocumentsSubmitted.tr(),
        style: AppTextStyles.xxxxsRegular.copyWith(color: colors.textMuted, height: _textHeight),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var index = 0; index < documents.length; index++) ...[
          if (index > 0) _rowGap,
          _SubmittedDocumentRow(name: documents[index].name),
        ],
      ],
    );
  }
}

class _SubmittedDocumentRow extends StatelessWidget {
  const _SubmittedDocumentRow({required this.name});

  final String name;

  static const _minHeight = 34.0;
  static const _padding = EdgeInsetsDirectional.symmetric(horizontal: 9, vertical: 7);
  static const _radius = BorderRadius.all(Radius.circular(7));
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: _minHeight),
      child: DecoratedBox(
        decoration: BoxDecoration(color: colors.selectedSurface, borderRadius: _radius),
        child: Padding(
          padding: _padding,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.xxxxxsMedium.copyWith(
                    color: colors.formLabel,
                    fontWeight: FontWeight.w400,
                    height: _textHeight,
                  ),
                ),
              ),
              AppSpacing.gapH8,
              Text(
                AppLocaleKey.documentSubmitted.tr(),
                style: AppTextStyles.xxxxxsMedium.copyWith(
                  color: colors.success,
                  fontWeight: FontWeight.w700,
                  height: _textHeight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
