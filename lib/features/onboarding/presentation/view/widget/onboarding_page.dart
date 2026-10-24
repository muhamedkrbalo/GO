import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/onboarding_item.dart';
import 'onboarding_hero_image.dart';

/// Hero image, eyebrow, title and description of one onboarding slide.
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key, required this.item, required this.index, required this.total});

  final OnboardingItem item;
  final int index;
  final int total;

  static const _heroHeight = 324.0;
  static const _heroStart = 32.0;
  static const _ringSize = 265.0;
  static const _ringStart = -112.0;
  static const _ringTop = 26.0;
  static const _ringBorderWidth = 1.6;
  static const _ringOpacity = 0.75;
  static const _heroToTextGap = 33.0;
  static const _maxTextWidth = 330.0;
  static const _eyebrowLetterSpacing = 1.8;
  static const _titleLetterSpacing = -1.18;
  static const _titleHeight = 1.07;
  static const _descriptionHeight = 1.53;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: _heroHeight,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                PositionedDirectional(
                  start: _heroStart,
                  end: 0,
                  top: 0,
                  bottom: 0,
                  child: OnboardingHeroImage(image: item.image, number: index + 1, total: total),
                ),
                PositionedDirectional(
                  start: _ringStart,
                  top: _ringTop,
                  child: Container(
                    width: _ringSize,
                    height: _ringSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colors.goldAccent.withValues(alpha: _ringOpacity),
                        width: _ringBorderWidth,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: _heroToTextGap),
          Padding(
            padding: AppPadding.h24,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _maxTextWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.eyebrowKey.tr().toUpperCase(),
                    style: AppTextStyles.xxxsBold.copyWith(
                      color: colors.eyebrow,
                      letterSpacing: _eyebrowLetterSpacing,
                    ),
                  ),
                  AppSpacing.gapV8,
                  Text(
                    item.titleKey.tr(),
                    style: AppTextStyles.xxxlBold.copyWith(
                      color: colors.accentText,
                      letterSpacing: _titleLetterSpacing,
                      height: _titleHeight,
                    ),
                  ),
                  AppSpacing.gapV15,
                  Text(
                    item.descriptionKey.tr(),
                    style: AppTextStyles.sRegular.copyWith(
                      color: colors.textMuted,
                      height: _descriptionHeight,
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
