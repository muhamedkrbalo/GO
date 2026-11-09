import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/ring_badge/ring_badge.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class BrokerTypeIntro extends StatelessWidget {
  const BrokerTypeIntro({super.key});

  static const _badgeSize = 38.0;
  static const _badgeInnerSize = 10.0;
  static const _badgeBorderWidth = 1.0;
  static const _badgeInnerBorderWidth = 2.0;
  static const _badgeOpacity = 0.62;
  static const _badgeToTitleGap = 20.0;
  static const _maxTitleWidth = 340.0;
  static const _maxSubtitleWidth = 330.0;
  static const _titleLetterSpacing = -0.98;
  static const _titleHeight = 1.18;
  static const _subtitleHeight = 1.6;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const RingBadge(
          size: _badgeSize,
          innerSize: _badgeInnerSize,
          borderWidth: _badgeBorderWidth,
          innerBorderWidth: _badgeInnerBorderWidth,
          outerOpacity: _badgeOpacity,
        ),
        const SizedBox(height: _badgeToTitleGap),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _maxTitleWidth),
          child: Text(
            AppLocaleKey.howWouldYouLikeToRegister.tr(),
            style: AppTextStyles.xxlSemiBold.copyWith(
              color: colors.textSecondary,
              letterSpacing: _titleLetterSpacing,
              height: _titleHeight,
            ),
          ),
        ),
        AppSpacing.gapV10,
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _maxSubtitleWidth),
          child: Text(
            AppLocaleKey.chooseBrokerAccountType.tr(),
            style: AppTextStyles.xs13Regular.copyWith(
              color: colors.textMuted,
              height: _subtitleHeight,
            ),
          ),
        ),
      ],
    );
  }
}
