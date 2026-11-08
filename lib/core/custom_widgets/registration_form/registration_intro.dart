import 'package:flutter/material.dart';

import '../../theme/app_sizes.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/extensions/theme_extensions.dart';

class RegistrationIntro extends StatelessWidget {
  const RegistrationIntro({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
  });

  final String eyebrow;
  final String title;
  final String subtitle;

  static const _maxTextWidth = 330.0;
  static const _eyebrowLetterSpacing = 1.26;
  static const _eyebrowHeight = 1.5;
  static const _titleLetterSpacing = -0.945;
  static const _titleHeight = 1.18;
  static const _subtitleHeight = 1.6;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: _maxTextWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            eyebrow.toUpperCase(),
            style: AppTextStyles.xxxxsBold.copyWith(
              color: colors.oceanAccent,
              letterSpacing: _eyebrowLetterSpacing,
              height: _eyebrowHeight,
            ),
          ),
          AppSpacing.gapV8,
          Text(
            title,
            style: AppTextStyles.xxlSemiBold.copyWith(
              color: colors.textSecondary,
              letterSpacing: _titleLetterSpacing,
              height: _titleHeight,
            ),
          ),
          AppSpacing.gapV10,
          Text(
            subtitle,
            style: AppTextStyles.xs13Regular.copyWith(
              color: colors.textMuted,
              height: _subtitleHeight,
            ),
          ),
        ],
      ),
    );
  }
}
