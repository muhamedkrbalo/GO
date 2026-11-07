import 'package:flutter/material.dart';

import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class DocumentSectionHeader extends StatelessWidget {
  const DocumentSectionHeader({
    super.key,
    required this.number,
    required this.title,
    required this.subtitle,
  });

  final int number;
  final String title;
  final String subtitle;

  static const _ringSize = 30.0;
  static const _ringOpacity = 0.5;
  static const _gap = SizedBox(width: 11);
  static const _lineGap = SizedBox(height: 2);
  static const _textHeight = 1.5;
  static const _subtitleHeight = 1.4;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Row(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: colors.accentBar.withValues(alpha: _ringOpacity)),
          ),
          child: SizedBox.square(
            dimension: _ringSize,
            child: Center(
              child: Text(
                '$number'.padLeft(2, '0'),
                style: AppTextStyles.xxxxsBold.copyWith(
                  color: colors.stepLabel,
                  height: _textHeight,
                ),
              ),
            ),
          ),
        ),
        _gap,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.xs13Bold.copyWith(
                  color: colors.textPrimary,
                  height: _textHeight,
                ),
              ),
              _lineGap,
              Text(
                subtitle,
                style: AppTextStyles.xxxxsRegular.copyWith(
                  color: colors.textMuted,
                  height: _subtitleHeight,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
