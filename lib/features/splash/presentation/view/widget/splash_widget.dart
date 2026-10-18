import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_erb/core/theme/app_text_styles.dart';
import 'package:flutter_hr_erb/core/theme/extensions/custom_colors_extension.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/locale/app_locale_key.dart';

/// Full-bleed villa photo with the GO logo at the top and the tagline at the
/// bottom.
class SplashWidget extends StatelessWidget {
  const SplashWidget({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(AppImages.assetsImagesSplashImage, fit: BoxFit.cover),
        Positioned(
          top: 46,
          left: 0,
          right: 0,
          child: Center(
            child: Image.asset(
              AppImages.assetsImagesGoSplashLogo,
              width: 135,
              height: 135,
              fit: BoxFit.cover,
            ),
          ),
        ),
         Positioned(
          left: 0,
          right: 0,
          bottom: 56,
          child: Text(
            AppLocaleKey.splashTagline.tr(),
            textAlign: TextAlign.center,
            style: AppTextStyles.sSemiBold.copyWith(
           color: Theme.of(context).customColors.surface,
            
            ),
          ),
        ),
      ],
    );
  }
}
