import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class WelcomeIntro extends StatelessWidget {
  const WelcomeIntro({super.key});

  static const _maxWidth = 330.0;
  static const _eyebrowLetterSpacing = 1.8;
  static const _titleLetterSpacing = -1.18;
  static const _titleHeight = 1.07;
  static const _subtitleHeight = 1.65;
  static const _subtitleGap = 14.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: _maxWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocaleKey.welcomeTag.tr().toUpperCase(),
            style: AppTextStyles.xxxsBold.copyWith(
              color: colors.onDarkEyebrow,
              letterSpacing: _eyebrowLetterSpacing,
            ),
          ),
          AppSpacing.gapV8,
          Text(
            AppLocaleKey.welcomeTitle.tr(),
            style: AppTextStyles.displayBold.copyWith(
              color: colors.onPrimary,
              letterSpacing: _titleLetterSpacing,
              height: _titleHeight,
            ),
          ),
          const SizedBox(height: _subtitleGap),
          Text(
            AppLocaleKey.welcomeSubtitle.tr(),
            style: AppTextStyles.xs13Regular.copyWith(
              color: colors.onDarkMuted,
              height: _subtitleHeight,
            ),
          ),
        ],
      ),
    );
  }
}
