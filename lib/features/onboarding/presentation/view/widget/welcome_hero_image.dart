import 'package:flutter/material.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

/// Square villa photo with rounded corners, a soft shadow and a light teal tint.
class WelcomeHeroImage extends StatelessWidget {
  const WelcomeHeroImage({super.key});

  static const _radius = BorderRadius.all(Radius.circular(16));

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.customColors.imagePlaceholder,
          borderRadius: _radius,
          boxShadow: AppShadows.card,
        ),
        child: ClipRRect(
          borderRadius: _radius,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(AppImages.assetsImagesWelcome, fit: BoxFit.cover),
              ColoredBox(color: AppColors.primaryDark.withValues(alpha: 0.07)),
            ],
          ),
        ),
      ),
    );
  }
}
