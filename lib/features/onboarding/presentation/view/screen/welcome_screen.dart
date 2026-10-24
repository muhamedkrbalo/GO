import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/custom_widgets/buttons/arrow_pill_button.dart';
import '../../../../../core/custom_widgets/buttons/custom_button.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../widget/welcome_hero.dart';
import '../widget/welcome_intro.dart';
import '../widget/welcome_legal_note.dart';

/// Entry point for signed-out users who have already seen onboarding.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const _sectionPadding = EdgeInsetsDirectional.fromSTEB(24, 14, 24, 28);
  static const _loginHeight = 50.0;
  static const _loginBorderOpacity = 0.25;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: colors.primary,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const WelcomeHero(),
              SafeArea(
                top: false,
                child: Padding(
                  padding: _sectionPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const WelcomeIntro(),
                      AppSpacing.gapV24,
                      ArrowPillButton(
                        text: AppLocaleKey.createAnAccount.tr(),
                        color: colors.onPrimary,
                        textColor: colors.primary,
                        onPressed: () => context.pushNamed(RouteNames.register),
                      ),
                      AppSpacing.gapV10,
                      CustomButton(
                        text: AppLocaleKey.logIn.tr(),
                        height: _loginHeight,
                        color: colors.primary,
                        borderColor: colors.onPrimary.withValues(alpha: _loginBorderOpacity),
                        borderRadius: AppRadius.brCircle,
                        prefixIcon: null,
                        suffixIcon: null,
                        style: AppTextStyles.xs13Bold.copyWith(color: colors.onPrimary),
                        onPressed: () => context.pushNamed(RouteNames.login),
                      ),
                      AppSpacing.gapV15,
                      const Center(child: WelcomeLegalNote()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
