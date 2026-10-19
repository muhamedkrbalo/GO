import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/onboarding_item.dart';

/// Illustration, tag, title and description of one onboarding slide.
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key, required this.item, required this.index});

  final OnboardingItem item;
  final int index;

  static const _illustrationWidth = 344.0;
  static const _maxTextWidth = 344.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final number = (index + 1).toString().padLeft(2, '0');

    return Padding(
      padding: AppPadding.t40h24b24,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _maxTextWidth),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child: SvgPicture.asset(item.illustration, width: _illustrationWidth)),
              AppSpacing.gapV32,
              Text(
                AppLocaleKey.onboardingTag.tr(args: [number]),
                textAlign: TextAlign.center,
                style: AppTextStyles.xxsBold.copyWith(
                  color: colors.textPrimary,
                  letterSpacing: 1.5,
                  height: 1.4,
                ),
              ),
              AppSpacing.gapV12,
              Text(
                item.titleKey.tr(),
                textAlign: TextAlign.center,
                style: AppTextStyles.xxlBold.copyWith(
                  color: colors.textSecondary,
                  letterSpacing: -1.1,
                  height: 1.16,
                ),
              ),
              AppSpacing.gapV15,
              Text(
                item.descriptionKey.tr(),
                textAlign: TextAlign.center,
                style: AppTextStyles.mRegular.copyWith(color: colors.textMuted, height: 1.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
