import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class BrokerSubmissionHero extends StatelessWidget {
  const BrokerSubmissionHero({
    super.key,
    this.titleKey = AppLocaleKey.registrationSubmittedTitle,
    this.subtitleKey = AppLocaleKey.brokerRegistrationSubmittedDescription,
    this.showLogo = true,
  });

  final String titleKey;
  final String subtitleKey;
  final bool showLogo;

  static const _logoWidth = 90.0;
  static const _logoHeight = 60.0;
  static const _logoGap = SizedBox(height: 26);
  static const _badgeSize = 80.0;
  static const _badgeBorderOpacity = 0.55;
  static const _checkSize = 30.0;
  static const _titleGap = SizedBox(height: 22);
  static const _subtitleGap = SizedBox(height: 9);
  static const _subtitleMaxWidth = 330.0;
  static const _titleLetterSpacing = -0.945;
  static const _titleHeight = 1.5;
  static const _subtitleHeight = 1.6;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Column(
      children: [
        if (showLogo) ...[
          Image.asset(
            AppImages.assetsImagesGoBrandLogo,
            width: _logoWidth,
            height: _logoHeight,
            cacheWidth: (_logoWidth * MediaQuery.devicePixelRatioOf(context)).round(),
            fit: BoxFit.cover,
          ),
          _logoGap,
        ],
        DecoratedBox(
          decoration: BoxDecoration(
            color: colors.oceanAccent,
            shape: BoxShape.circle,
            border: Border.all(color: colors.accentBar.withValues(alpha: _badgeBorderOpacity)),
            boxShadow: AppShadows.heroBadge,
          ),
          child: SizedBox.square(
            dimension: _badgeSize,
            child: Icon(Icons.check_rounded, size: _checkSize, color: colors.onPrimary),
          ),
        ),
        _titleGap,
        Text(
          titleKey.tr(),
          textAlign: TextAlign.center,
          style: AppTextStyles.xxlSemiBold.copyWith(
            color: colors.textSecondary,
            letterSpacing: _titleLetterSpacing,
            height: _titleHeight,
          ),
        ),
        _subtitleGap,
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _subtitleMaxWidth),
          child: Text(
            subtitleKey.tr(),
            textAlign: TextAlign.center,
            style: AppTextStyles.xsRegular.copyWith(
              color: colors.textMuted,
              height: _subtitleHeight,
            ),
          ),
        ),
      ],
    );
  }
}
