import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class BusinessRoleIntro extends StatelessWidget {
  const BusinessRoleIntro({super.key});

  static const _barWidth = 2.0;
  static const _barTopOffset = 3.0;
  static const _barToTextGap = 14.0;
  static const _maxTextWidth = 320.0;
  static const _titleLetterSpacing = -0.945;
  static const _titleHeight = 1.18;
  static const _subtitleHeight = 1.55;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(top: _barTopOffset),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: AppRadius.brCircle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [colors.cyanAccent, colors.accentBar],
                ),
              ),
              child: const SizedBox(width: _barWidth),
            ),
          ),
          const SizedBox(width: _barToTextGap),
          Flexible(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _maxTextWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocaleKey.howWouldYouLikeToJoinGo.tr(),
                    style: AppTextStyles.xxlSemiBold.copyWith(
                      color: colors.textSecondary,
                      letterSpacing: _titleLetterSpacing,
                      height: _titleHeight,
                    ),
                  ),
                  AppSpacing.gapV10,
                  Text(
                    AppLocaleKey.chooseBusinessRelationship.tr(),
                    style: AppTextStyles.xs13Regular.copyWith(
                      color: colors.textMuted,
                      height: _subtitleHeight,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
