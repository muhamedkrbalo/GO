import 'package:flutter/material.dart';

import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class OwnerPackagesIntro extends StatelessWidget {
  const OwnerPackagesIntro({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
  });

  final String eyebrow;
  final String title;
  final String subtitle;

  static const _maxTextWidth = 342.0;
  static const _titleGap = SizedBox(height: 7);
  static const _subtitleGap = SizedBox(height: 9);
  static const _eyebrowLetterSpacing = 1.26;
  static const _eyebrowHeight = 1.5;
  static const _titleLetterSpacing = -0.945;
  static const _titleHeight = 1.18;
  static const _subtitleHeight = 1.55;

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
          _titleGap,
          Text(
            title,
            style: AppTextStyles.xxlSemiBold.copyWith(
              color: colors.textSecondary,
              letterSpacing: _titleLetterSpacing,
              height: _titleHeight,
            ),
          ),
          _subtitleGap,
          Text(
            subtitle,
            style: AppTextStyles.xsRegular.copyWith(
              color: colors.textMuted,
              height: _subtitleHeight,
            ),
          ),
        ],
      ),
    );
  }
}
