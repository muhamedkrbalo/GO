import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/custom_widgets/buttons/custom_button.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/verification_method.dart';
import '../../../data/model/verify_account_args.dart';
import '../../../data/model/verify_code_args.dart';
import '../../controller/verify_account_cubit.dart';
import '../widget/auth_step_header.dart';
import '../widget/code_sent_banner.dart';
import '../widget/verification_method_card.dart';
import '../widget/verify_account_badge.dart';

class VerifyAccountScreen extends StatelessWidget {
  const VerifyAccountScreen({super.key, required this.args});

  final VerifyAccountArgs args;

  static const _contentPadding = EdgeInsetsDirectional.fromSTEB(24, 30, 24, 40);
  static const _ringSize = 288.0;
  static const _ringTop = -118.0;
  static const _ringEnd = -132.0;
  static const _ringOpacity = 0.22;
  static const _ringBorderWidth = 1.6;
  static const _maxTextWidth = 330.0;
  static const _maxNoteWidth = 290.0;
  static const _badgeToTitleGap = 24.0;
  static const _subtitleToCardsGap = 34.0;
  static const _cardsToActionsGap = 28.0;
  static const _bannerToButtonGap = 19.0;
  static const _buttonTopGap = 7.0;
  static const _buttonHeight = 52.0;
  static const _buttonRadius = 12.0;
  static const _titleLetterSpacing = -0.7;
  static const _titleHeight = 1.2;
  static const _subtitleHeight = 1.6;
  static const _noteHeight = 1.5;
  static const _codeEntryDelay = Duration(milliseconds: 1200);

  Future<void> _openCodeEntry(BuildContext context, VerificationMethod method) async {
    final cubit = context.read<VerifyAccountCubit>();
    await Future<void>.delayed(_codeEntryDelay);
    if (!context.mounted) return;
    await context.pushNamed(
      RouteNames.verifyCode,
      extra: VerifyCodeArgs(method: method, account: args),
    );
    if (!cubit.isClosed) cubit.resetCodeSent();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return BlocListener<VerifyAccountCubit, VerifyAccountState>(
      listenWhen: (previous, current) => !previous.isCodeSent && current.isCodeSent,
      listener: (context, state) => _openCodeEntry(context, state.method!),
      child: Scaffold(
        backgroundColor: colors.canvas,
        body: SafeArea(
          child: Stack(
            children: [
              PositionedDirectional(
                top: _ringTop,
                end: _ringEnd,
                child: Container(
                  width: _ringSize,
                  height: _ringSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colors.accentBar.withValues(alpha: _ringOpacity),
                      width: _ringBorderWidth,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  AuthStepHeader(
                    step: 2,
                    stepCount: 3,
                    backgroundColor: colors.canvas.withValues(alpha: 0),
                  ),
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverPadding(
                          padding: _contentPadding,
                          sliver: SliverFillRemaining(
                            hasScrollBody: false,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const VerifyAccountBadge(),
                                const SizedBox(height: _badgeToTitleGap),
                                ConstrainedBox(
                                  constraints: const BoxConstraints(maxWidth: _maxTextWidth),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocaleKey.verifyYourAccount.tr(),
                                        style: AppTextStyles.xxlSemiBold.copyWith(
                                          color: colors.textSecondary,
                                          letterSpacing: _titleLetterSpacing,
                                          height: _titleHeight,
                                        ),
                                      ),
                                      AppSpacing.gapV10,
                                      Text(
                                        AppLocaleKey.chooseHowToReceiveVerificationCode.tr(),
                                        style: AppTextStyles.sRegular.copyWith(
                                          color: colors.textMuted,
                                          height: _subtitleHeight,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: _subtitleToCardsGap),
                                for (final method in VerificationMethod.values) ...[
                                  if (method.index > 0) AppSpacing.gapV12,
                                  BlocSelector<VerifyAccountCubit, VerifyAccountState, bool>(
                                    selector: (state) => state.method == method,
                                    builder: (context, isSelected) => VerificationMethodCard(
                                      method: method,
                                      destination: args.maskedDestination(method),
                                      isSelected: isSelected,
                                      onTap: () =>
                                          context.read<VerifyAccountCubit>().selectMethod(method),
                                    ),
                                  ),
                                ],
                                const Spacer(),
                                const SizedBox(height: _cardsToActionsGap),
                                BlocBuilder<VerifyAccountCubit, VerifyAccountState>(
                                  builder: (context, state) => Column(
                                    children: [
                                      if (state.isCodeSent) ...[
                                        const CodeSentBanner(),
                                        const SizedBox(height: _bannerToButtonGap),
                                      ] else
                                        const SizedBox(height: _buttonTopGap),
                                      CustomButton(
                                        text: AppLocaleKey.continue_.tr(),
                                        height: _buttonHeight,
                                        radius: _buttonRadius,
                                        hasShadow: true,
                                        isEnabled: state.canContinue,
                                        disabledColor: colors.subtleBorder,
                                        disabledBorderColor: colors.subtleBorder,
                                        disabledTextColor: colors.grey,
                                        onPressed: context.read<VerifyAccountCubit>().sendCode,
                                      ),
                                    ],
                                  ),
                                ),
                                AppSpacing.gapV12,
                                Center(
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(maxWidth: _maxNoteWidth),
                                    child: Text(
                                      AppLocaleKey.contactDetailPrivacyNote.tr(),
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.xxxsRegular.copyWith(
                                        color: colors.grey,
                                        height: _noteHeight,
                                      ),
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
