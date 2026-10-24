import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class RegisterTitle extends StatelessWidget {
  const RegisterTitle({super.key});

  static const _textStart = 16.0;
  static const _barWidth = 2.0;
  static const _barTop = 2.0;
  static const _barBottom = 1.0;
  static const _titleLetterSpacing = -0.7;
  static const _titleHeight = 1.2;
  static const _subtitleHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: _textStart),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocaleKey.createAnAccount.tr(),
                style: AppTextStyles.xxlSemiBold.copyWith(
                  color: colors.textSecondary,
                  letterSpacing: _titleLetterSpacing,
                  height: _titleHeight,
                ),
              ),
              AppSpacing.gapV8,
              Text(
                AppLocaleKey.createAccountSubtitle.tr(),
                style: AppTextStyles.sRegular.copyWith(
                  color: colors.textMuted,
                  height: _subtitleHeight,
                ),
              ),
            ],
          ),
        ),
        PositionedDirectional(
          start: 0,
          top: _barTop,
          bottom: _barBottom,
          width: _barWidth,
          child: DecoratedBox(
            decoration: BoxDecoration(color: colors.accentBar, borderRadius: AppRadius.brCircle),
          ),
        ),
      ],
    );
  }
}
