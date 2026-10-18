import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/custom_widgets/buttons/custom_button.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../widget/welcome_hero_image.dart';

/// Entry point for signed-out users who have already seen onboarding.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Padding(
          padding: AppPadding.t40h24b20,
          child: Column(
            children: [
            
              Expanded(
                child: Column(
                  children: [
                    const Flexible(child: WelcomeHeroImage()),
                    AppSpacing.gapV32,
                    Text(
                      AppLocaleKey.welcomeTag.tr(),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.xxsBold.copyWith(
                        color: colors.textPrimary,
                        letterSpacing: 1.6,
                        height: 1.4,
                      ),
                    ),
                    AppSpacing.gapV10,
                    Text(
                      AppLocaleKey.welcomeTitle.tr(),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.xxxlBold.copyWith(
                        color: colors.textSecondary,
                        letterSpacing: -1.4,
                        height: 1.15,
                      ),
                    ),
                    AppSpacing.gapV10,
                    Text(
                      AppLocaleKey.welcomeSubtitle.tr(),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.mRegular.copyWith(color: colors.textMuted, height: 1.6),
                    ),
                  ],
                ),
              ),
              CustomButton(
                text: AppLocaleKey.createAnAccount.tr(),
                hasShadow: true,
                boxShadow: AppShadows.primaryButton,
                // TODO: go to the register screen once it exists.
                onPressed: () => context.pushNamed(RouteNames.login),
              ),
              AppSpacing.gapV12,
              CustomButton(
                text: AppLocaleKey.logIn.tr(),
                color: colors.surface,
                borderColor: colors.border,
                textColor: colors.accentText,
                onPressed: () => context.pushNamed(RouteNames.login),
              ),
              AppSpacing.gapV20,
              Text(
                AppLocaleKey.splashTagline.tr(),
                textAlign: TextAlign.center,
                style: AppTextStyles.xsMedium.copyWith(color: colors.textMuted, letterSpacing: 0.4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
