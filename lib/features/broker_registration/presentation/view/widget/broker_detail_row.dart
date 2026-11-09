import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class BrokerDetailRow extends StatelessWidget {
  const BrokerDetailRow({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
    this.textDirection,
    this.hasDivider = true,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final ui.TextDirection? textDirection;
  final bool hasDivider;

  static const _padding = EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 12);
  static const _gap = SizedBox(width: 12);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: hasDivider ? Border(bottom: BorderSide(color: colors.subtleBorder)) : null,
      ),
      child: Padding(
        padding: _padding,
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.xxxxxsMedium.copyWith(
                  color: colors.hint,
                  fontWeight: FontWeight.w400,
                  height: _textHeight,
                ),
              ),
            ),
            _gap,
            Text(
              value,
              textDirection: textDirection,
              style: AppTextStyles.xxxxsBold.copyWith(
                color: valueColor ?? colors.textPrimary,
                height: _textHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
