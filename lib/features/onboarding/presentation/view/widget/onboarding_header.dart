import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({super.key, required this.onSkip});

  final VoidCallback onSkip;

  static const _logoWidth = 104.0;
  static const _logoHeight = 69.0;
  static const _skipMinSize = Size(48, 44);
  static const _skipLetterSpacing = 0.78;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          AppImages.assetsImagesGoBrandLogo,
          width: _logoWidth,
          height: _logoHeight,
          fit: BoxFit.cover,
        ),
        TextButton(
          onPressed: onSkip,
          style: TextButton.styleFrom(
            minimumSize: _skipMinSize,
            foregroundColor: context.customColors.linkMuted,
            textStyle: AppTextStyles.xsSemiBold.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: _skipLetterSpacing,
            ),
          ),
          child: Text(AppLocaleKey.skip.tr()),
        ),
      ],
    );
  }
}
