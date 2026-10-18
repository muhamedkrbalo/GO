import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/buttons/custom_button.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/verification_method.dart';
import '../../../data/model/verify_account_args.dart';
import '../../controller/verify_account_cubit.dart';
import '../widget/auth_header.dart';
import '../widget/verification_method_card.dart';

class VerifyAccountScreen extends StatelessWidget {
  const VerifyAccountScreen({super.key, required this.args});

  final VerifyAccountArgs args;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: AppPadding.t15h24b24,
              sliver: SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AuthHeader(),
                    AppSpacing.gapV52,
                    Text(
                      AppLocaleKey.accountSecurity.tr(),
                      style: AppTextStyles.xxsBold.copyWith(
                        color: colors.textPrimary,
                        letterSpacing: 1.6,
                        height: 1.4,
                      ),
                    ),
                    AppSpacing.gapV12,
                    Text(
                      AppLocaleKey.verifyYourAccount.tr(),
                      style: AppTextStyles.xxxlBold.copyWith(
                        color: colors.textSecondary,
                        letterSpacing: -1.4,
                        height: 1.18,
                      ),
                    ),
                    AppSpacing.gapV12,
                    Text(
                      AppLocaleKey.chooseHowToReceiveVerificationCode.tr(),
                      style: AppTextStyles.mRegular.copyWith(color: colors.textMuted, height: 1.6),
                    ),
                    AppSpacing.gapV32,
                    for (final method in VerificationMethod.values) ...[
                      if (method.index > 0) AppSpacing.gapV15,
                      BlocSelector<VerifyAccountCubit, VerificationMethod, bool>(
                        selector: (selected) => selected == method,
                        builder: (context, isSelected) => VerificationMethodCard(
                          method: method,
                          destination: args.maskedDestination(method),
                          isSelected: isSelected,
                          onTap: () => context.read<VerifyAccountCubit>().selectMethod(method),
                        ),
                      ),
                    ],
                    const Spacer(),
                    AppSpacing.gapV24,
                    CustomButton(
                      text: AppLocaleKey.sendVerificationCode.tr(),
                      hasShadow: true,
                      boxShadow: AppShadows.primaryButton,
                    ),
                    AppSpacing.gapV15,
                    Center(
                      child: Text(
                        AppLocaleKey.contactDetailPrivacyNote.tr(),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.xxsRegular.copyWith(
                          color: colors.textMuted,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
