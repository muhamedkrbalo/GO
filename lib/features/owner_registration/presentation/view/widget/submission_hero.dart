import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class SubmissionHero extends StatelessWidget {
  const SubmissionHero({super.key});

  static const _ringSize = 108.0;
  static const _ringOpacity = 0.5;
  static const _badgeSize = 86.0;
  static const _iconSize = 64.0;
  static const _eyebrowGap = SizedBox(height: 19);
  static const _titleGap = SizedBox(height: 7);
  static const _subtitleGap = SizedBox(height: 10);
  static const _subtitleMaxWidth = 335.0;
  static const _eyebrowLetterSpacing = 1.44;
  static const _titleLetterSpacing = -0.98;
  static const _eyebrowHeight = 1.5;
  static const _titleHeight = 1.2;
  static const _subtitleHeight = 1.6;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: colors.accentBar.withValues(alpha: _ringOpacity)),
          ),
          child: SizedBox.square(
            dimension: _ringSize,
            child: Center(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: AppShadows.heroBadge,
                  gradient: LinearGradient(
                    begin: AlignmentDirectional.topStart,
                    end: AlignmentDirectional.bottomEnd,
                    colors: [colors.iconTileSurface, colors.surface],
                  ),
                ),
                child: SizedBox.square(
                  dimension: _badgeSize,
                  child: Center(
                    child: SvgPicture.asset(
                      AppImages.assetsSvgSubmissionDocument,
                      width: _iconSize,
                      height: _iconSize,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        _eyebrowGap,
        Text(
          AppLocaleKey.submissionReceived.tr().toUpperCase(),
          textAlign: TextAlign.center,
          style: AppTextStyles.xxxxsBold.copyWith(
            color: colors.oceanAccent,
            letterSpacing: _eyebrowLetterSpacing,
            height: _eyebrowHeight,
          ),
        ),
        _titleGap,
        Text(
          AppLocaleKey.registrationSubmitted.tr(),
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
            AppLocaleKey.registrationSubmittedDescription.tr(),
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
