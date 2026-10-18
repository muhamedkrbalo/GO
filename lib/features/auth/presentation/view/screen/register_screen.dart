import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/register_cubit.dart';
import '../widget/have_account_prompt.dart';
import '../widget/register_form.dart';
import '../widget/register_header.dart';
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
              const RegisterHeader(),
              AppSpacing.gapV20,
             const RegisterStepIndicator(step: 1, stepCount: 3),
              AppSpacing.gapV32,
              Text(
                AppLocaleKey.createYourAccount.tr(),
                style: AppTextStyles.xxlBold.copyWith(
                  color: colors.textSecondary,
                  letterSpacing: -1.1,
                  height: 1.2,
                ),
              ),
              AppSpacing.gapV8,
              Text(
                AppLocaleKey.enterYourDetailsToGetStarted.tr(),
                style: AppTextStyles.sRegular.copyWith(color: colors.textMuted, height: 1.55),
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
