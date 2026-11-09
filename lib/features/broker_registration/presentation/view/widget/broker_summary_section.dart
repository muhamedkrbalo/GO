import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/registration_form/review_info_rows.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class BrokerSummarySection extends StatelessWidget {
  const BrokerSummarySection({
    super.key,
    required this.title,
    required this.items,
    required this.onEdit,
  });

  final String title;
  final List<ReviewInfoItem> items;
  final VoidCallback onEdit;

  static const _radius = BorderRadius.all(Radius.circular(12));
  static const _headerMinHeight = 48.0;
  static const _headerPadding = EdgeInsetsDirectional.fromSTEB(13, 7, 5, 7);
  static const _bodyPadding = EdgeInsetsDirectional.symmetric(horizontal: 13, vertical: 5);
  static const _editMinSize = Size(44, 34);
  static const _editPadding = EdgeInsetsDirectional.symmetric(horizontal: 8);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Material(
      color: colors.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: _radius,
        side: BorderSide(color: colors.subtleBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: colors.selectedSurface)),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: _headerMinHeight),
              child: Padding(
                padding: _headerPadding,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.xxsBold.copyWith(
                          color: colors.textPrimary,
                          height: _textHeight,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: onEdit,
                      style: TextButton.styleFrom(
                        minimumSize: _editMinSize,
                        padding: _editPadding,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        foregroundColor: colors.oceanAccent,
                        textStyle: AppTextStyles.xxxxxsMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          height: _textHeight,
                        ),
                      ),
                      child: Text(AppLocaleKey.edit.tr()),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: _bodyPadding,
            child: ReviewInfoRows(items: items),
          ),
        ],
      ),
    );
  }
}
