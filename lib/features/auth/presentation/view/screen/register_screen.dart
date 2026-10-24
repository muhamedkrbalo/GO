import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../widget/auth_header.dart';
import '../widget/have_account_prompt.dart';
import '../widget/register_form.dart';
import '../widget/register_step_indicator.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppPadding.t15h24b24,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AuthHeader(),
              AppSpacing.gapV20,
              const RegisterStepIndicator(step: 1, stepCount: 3),
              AppSpacing.gapV32,
              Text(
                AppLocaleKey.createYourAccount.tr(),
                style: AppTextStyles.xxlSemiBold.copyWith(
                  color: colors.textSecondary,
                  letterSpacing: -0.7,
                  height: 1.2,
                ),
              ),
              AppSpacing.gapV8,
              Text(
                AppLocaleKey.enterYourDetailsToGetStarted.tr(),
                style: AppTextStyles.sRegular.copyWith(color: colors.textMuted, height: 1.5),
              ),
              AppSpacing.gapV24,
              const RegisterForm(),
              AppSpacing.gapV20,
              const HaveAccountPrompt(),
            ],
          ),
        ),
      ),
    );
  }
}
