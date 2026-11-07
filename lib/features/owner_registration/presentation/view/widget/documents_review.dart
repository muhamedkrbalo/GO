import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/owner_document.dart';
import '../../../data/model/owner_unit.dart';

class DocumentsReview extends StatelessWidget {
  const DocumentsReview({super.key, required this.units, required this.documents});

  final List<OwnerUnit> units;
  final Map<DocumentSlot, UploadedDocument> documents;

  static const _topPadding = EdgeInsetsDirectional.only(top: 10);
  static const _groupGap = SizedBox(height: 7);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _topPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _DocumentGroup(
            title: AppLocaleKey.ownerDocuments.tr(),
            slots: [for (final type in DocumentType.ownerTypes) DocumentSlot(type)],
            documents: documents,
          ),
          for (final unit in units) ...[
            _groupGap,
            _DocumentGroup(
              title: unit.name,
              slots: [
                for (final type in DocumentType.unitTypes) DocumentSlot(type, unitId: unit.id),
              ],
              documents: documents,
              hasTopDivider: true,
            ),
          ],
        ],
      ),
    );
  }
}

class _DocumentGroup extends StatelessWidget {
  const _DocumentGroup({
    required this.title,
    required this.slots,
    required this.documents,
    this.hasTopDivider = false,
  });

  final String title;
  final List<DocumentSlot> slots;
  final Map<DocumentSlot, UploadedDocument> documents;
  final bool hasTopDivider;

  static const _dividerPadding = EdgeInsetsDirectional.only(top: 10);
  static const _rowGap = SizedBox(height: 6);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: AppTextStyles.xxxxsBold.copyWith(color: colors.textPrimary, height: _textHeight),
        ),
        for (final slot in slots) ...[
          _rowGap,
          _DocumentRow(title: slot.type.titleKey.tr(), document: documents[slot]),
        ],
      ],
    );

    if (!hasTopDivider) return content;
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: colors.subtleBorder)),
      ),
      child: Padding(padding: _dividerPadding, child: content),
    );
  }
}

class _DocumentRow extends StatelessWidget {
  const _DocumentRow({required this.title, required this.document});

  final String title;
  final UploadedDocument? document;

  static const _minHeight = 32.0;
  static const _padding = EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 6);
  static const _radius = BorderRadius.all(Radius.circular(7));
  static const _maxValueWidth = 130.0;
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final document = this.document;
    final isUploaded = document != null;

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: _minHeight),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isUploaded ? colors.selectedSurface : colors.errorSurface,
          borderRadius: _radius,
        ),
        child: Padding(
          padding: _padding,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.xxxxxsMedium.copyWith(
                    color: colors.formLabel,
                    fontWeight: FontWeight.w600,
                    height: _textHeight,
                  ),
                ),
              ),
              AppSpacing.gapH8,
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: _maxValueWidth),
                child: Text(
                  isUploaded ? document.name : AppLocaleKey.notUploaded.tr(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.xxxxxsMedium.copyWith(
                    color: isUploaded ? colors.success : colors.error,
                    fontWeight: isUploaded ? FontWeight.w400 : FontWeight.w700,
                    height: _textHeight,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
