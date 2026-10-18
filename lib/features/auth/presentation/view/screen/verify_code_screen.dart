import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/extension/context_ui_extension.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/verify_code_cubit.dart';
import '../widget/auth_header.dart';
import '../widget/resend_code_button.dart';
import '../widget/verification_code_input.dart';
import '../widget/verification_code_message.dart';
import '../widget/verify_code_button.dart';

class VerifyCodeScreen extends StatelessWidget {
  const VerifyCodeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final destination = context.read<VerifyCodeCubit>().args.maskedDestination;

    return BlocListener<VerifyCodeCubit, VerifyCodeState>(
      listenWhen: (previous, current) =>
          previous.status != current.status && current.status == VerifyCodeStatus.verified,
      listener: (context, _) => context.showToast(message: AppLocaleKey.accountVerified.tr()),
      child: Scaffold(
        backgroundColor: colors.surface,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: AppPadding.t15h24b24,
                sliver: SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      const AuthHeader(),
                      AppSpacing.gapV52,
                      AppSpacing.gapV10,
                      Text(
                        AppLocaleKey.secureVerification.tr(),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.sBold.copyWith(
                          color: colors.textMuted,
                          letterSpacing: 2.2,
                          height: 1.6,
                        ),
                      ),
                      Text(
                        AppLocaleKey.enterVerificationCode.tr(),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.xxlBold.copyWith(
                          color: colors.textSecondary,
                          letterSpacing: -1.2,
                          height: 1.25,
                        ),
                      ),
                      AppSpacing.gapV12,
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 320.0),
                        child: Text(
                          AppLocaleKey.weSentAVerificationCode.tr(),
                          textAlign: TextAlign.center,
                          style: AppTextStyles.sRegular.copyWith(
                            color: colors.textMuted,
                            height: 1.6,
                          ),
                        ),
                      ),
                      AppSpacing.gapV12,
                      Text(
                        destination,
                        textDirection: ui.TextDirection.ltr,
                        style: AppTextStyles.sBold.copyWith(
                          color: colors.accentText,
                          letterSpacing: 0.36,
                        ),
                      ),
                      AppSpacing.gapV40,
                      const VerificationCodeInput(),
                      const VerificationCodeMessage(),
                      const ResendCodeButton(),
                      AuthTextButton(
                        label: AppLocaleKey.changeVerificationMethod.tr(),
                        onPressed: context.pop,
                      ),
                      const Spacer(),
                      AppSpacing.gapV24,
                      const VerifyCodeButton(),
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
