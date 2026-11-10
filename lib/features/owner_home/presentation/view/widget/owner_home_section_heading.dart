import 'package:flutter/material.dart';

import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class OwnerHomeSectionHeading extends StatelessWidget {
  const OwnerHomeSectionHeading({
    super.key,
    required this.eyebrow,
    required this.title,
    this.trailing,
  });

  final String eyebrow;
  final String title;
  final Widget? trailing;

  static const _titleGap = SizedBox(height: 3);
  static const _trailingGap = SizedBox(width: 12);
  static const _eyebrowLetterSpacing = 1.12;
  static const _eyebrowHeight = 1.5;
  static const _titleHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final trailing = this.trailing;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                eyebrow.toUpperCase(),
                style: AppTextStyles.xxxxxsMedium.copyWith(
                  color: colors.oceanAccent,
                  fontWeight: FontWeight.w800,
                  letterSpacing: _eyebrowLetterSpacing,
                  height: _eyebrowHeight,
                ),
              ),
              _titleGap,
              Text(
                title,
                style: AppTextStyles.xs13Bold.copyWith(
                  color: colors.textPrimary,
                  height: _titleHeight,
                ),
              ),
            ],
          ),
        ),
        if (trailing != null) ...[_trailingGap, trailing],
      ],
    );
  }
}
