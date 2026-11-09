import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../locale/app_locale_key.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/extensions/theme_extensions.dart';

class ReviewInfoItem {
  const ReviewInfoItem({required this.label, required this.rawValue, this.isLtr = false});

  final String label;
  final String? rawValue;
  final bool isLtr;

  bool get isProvided => rawValue?.trim().isNotEmpty ?? false;

  String get value => isProvided ? rawValue! : AppLocaleKey.notProvided.tr();
}

class ReviewInfoRows extends StatelessWidget {
  const ReviewInfoRows({super.key, required this.items});

  final List<ReviewInfoItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var index = 0; index < items.length; index++)
          _ReviewInfoRow(item: items[index], hasDivider: index < items.length - 1),
      ],
    );
  }
}

class _ReviewInfoRow extends StatelessWidget {
  const _ReviewInfoRow({required this.item, required this.hasDivider});

  final ReviewInfoItem item;
  final bool hasDivider;

  static const _padding = EdgeInsetsDirectional.symmetric(vertical: 10);
  static const _gap = SizedBox(width: 12);
  static const _labelFlex = 4;
  static const _valueFlex = 5;
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: hasDivider ? Border(bottom: BorderSide(color: colors.selectedSurface)) : null,
      ),
      child: Padding(
        padding: _padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: _labelFlex,
              child: Text(
                item.label,
                style: AppTextStyles.xxxxxsMedium.copyWith(
                  color: colors.textMuted,
                  fontWeight: FontWeight.w600,
                  height: _textHeight,
                ),
              ),
            ),
            _gap,
            Expanded(
              flex: _valueFlex,
              child: Text(
                item.value,
                textAlign: TextAlign.end,
                textDirection: item.isLtr && item.isProvided ? ui.TextDirection.ltr : null,
                style: AppTextStyles.xxxxsBold.copyWith(
                  color: colors.formLabel,
                  height: _textHeight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
