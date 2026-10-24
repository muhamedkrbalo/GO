import 'package:flutter/material.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class SplashLogoBadge extends StatelessWidget {
  const SplashLogoBadge({super.key});

  static const _size = 296.0;
  static const _borderWidth = 1.6;
  static const _borderOpacity = 0.12;
  static const _logoWidth = 240.0;
  static const _logoHeight = 160.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    return Container(
      width: _size,
      height: _size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colors.logoBackground,
        shape: BoxShape.circle,
        border: Border.all(
          color: colors.brandGradientEnd.withValues(alpha: _borderOpacity),
          width: _borderWidth,
        ),
        boxShadow: AppShadows.logoBadge,
      ),
      child: Image.asset(
        AppImages.assetsImagesGoBrandLogo,
        width: _logoWidth,
        height: _logoHeight,
        fit: BoxFit.cover,
      ),
    );
  }
}
