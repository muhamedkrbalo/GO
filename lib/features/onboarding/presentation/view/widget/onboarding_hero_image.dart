import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class OnboardingHeroImage extends StatelessWidget {
  const OnboardingHeroImage({
    super.key,
    required this.image,
    required this.number,
    required this.total,
  });

  final String image;
  final int number;
  final int total;

  static const _radius = BorderRadiusDirectional.horizontal(start: Radius.circular(170));
  static const _scrimOpacity = 0.46;
  static const _counterInset = 18.0;
  static const _labelStart = 84.0;
  static const _labelBottom = 24.0;
  static const _labelLineWidth = 22.0;
  static const _labelLineHeight = 1.0;
  static const _labelLetterSpacing = 1.8;
  static const _counterLetterSpacing = 0.5;

  String _pad(int value) => value.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.imagePlaceholder,
        borderRadius: _radius,
        boxShadow: AppShadows.onboardingImage,
      ),
      child: ClipRRect(
        borderRadius: _radius,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(image, fit: BoxFit.cover),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: [
                    colors.imageScrim.withValues(alpha: _scrimOpacity),
                    colors.imageScrim.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
            PositionedDirectional(
              top: _counterInset,
              end: _counterInset,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    _pad(number),
                    style: AppTextStyles.xxxlBold.copyWith(
                      color: colors.onPrimary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  AppSpacing.gapH5,
                  Text(
                    '— ${_pad(total)}',
                    style: AppTextStyles.xxxsSemiBold.copyWith(
                      color: colors.onPrimary,
                      letterSpacing: _counterLetterSpacing,
                    ),
                  ),
                ],
              ),
            ),
            PositionedDirectional(
              start: _labelStart,
              bottom: _labelBottom,
              child: Row(
                children: [
                  Container(
                    width: _labelLineWidth,
                    height: _labelLineHeight,
                    color: colors.goldGradientStart,
                  ),
                  AppSpacing.gapH8,
                  Text(
                    AppLocaleKey.goCollection.tr(),
                    style: AppTextStyles.xxxsBold.copyWith(
                      color: colors.onPrimary,
                      letterSpacing: _labelLetterSpacing,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
