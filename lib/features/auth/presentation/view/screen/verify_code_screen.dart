import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/verify_code_args.dart';
import '../widget/auth_step_header.dart';
import '../widget/code_expiry_label.dart';
import '../widget/go_monogram_badge.dart';
import '../widget/resend_code_button.dart';
import '../widget/skip_verification_button.dart';
import '../widget/verification_code_input.dart';
import '../widget/verify_code_button.dart';

class VerifyCodeScreen extends StatelessWidget {
  const VerifyCodeScreen({super.key, required this.args});

  final VerifyCodeArgs args;

  static const _contentPadding = EdgeInsetsDirectional.fromSTEB(24, 28, 24, 40);
  static const _ringSize = 320.0;
  static const _ringTop = -152.0;
  static const _ringEnd = -126.0;
  static const _ringOpacity = 0.2;
  static const _maxTextWidth = 330.0;
  static const _badgeToTitleGap = 22.0;
  static const _destinationTopGap = 12.0;
  static const _destinationToCodeGap = 38.0;
  static const _actionsTopGap = 35.0;
  static const _actionsGap = 18.0;
  static const _titleLetterSpacing = -0.7;
  static const _titleHeight = 1.2;
  static const _subtitleHeight = 1.6;
  static const _destinationLetterSpacing = 0.325;
  static const _destinationHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Scaffold(
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
                  border: Border.all(color: colors.accentBar.withValues(alpha: _ringOpacity)),
                ),
              ),
            ),
            Column(
              children: [
                AuthStepHeader(
                  step: 3,
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
                            children: [
                              const GoMonogramBadge(),
                              const SizedBox(height: _badgeToTitleGap),
                              Text(
                                AppLocaleKey.verifyYourAccount.tr(),
                                textAlign: TextAlign.center,
                                style: AppTextStyles.xxlSemiBold.copyWith(
                                  color: colors.textSecondary,
                                  letterSpacing: _titleLetterSpacing,
                                  height: _titleHeight,
                                ),
                              ),
                              AppSpacing.gapV10,
                              ConstrainedBox(
                                constraints: const BoxConstraints(maxWidth: _maxTextWidth),
                                child: Text(
                                  AppLocaleKey.enterCodeSentToContact.tr(),
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.sRegular.copyWith(
                                    color: colors.textMuted,
                                    height: _subtitleHeight,
                                  ),
                                ),
                              ),
                              const SizedBox(height: _destinationTopGap),
                              Text(
                                args.maskedDestination,
                                textDirection: ui.TextDirection.ltr,
                                textAlign: TextAlign.center,
                                style: AppTextStyles.xs13Bold.copyWith(
                                  color: colors.textPrimary,
                                  letterSpacing: _destinationLetterSpacing,
                                  height: _destinationHeight,
                                ),
                              ),
                              const SizedBox(height: _destinationToCodeGap),
                              const VerificationCodeInput(),
                              const CodeExpiryLabel(),
                              const Spacer(),
                              const SizedBox(height: _actionsTopGap),
                              const VerifyCodeButton(),
                              const SizedBox(height: _actionsGap),
                              const ResendCodeButton(),
                              AppSpacing.gapV5,
                              AuthTextButton(
                                label: AppLocaleKey.changeVerificationMethod.tr(),
                                onPressed: context.pop,
                              ),
                              if (kDebugMode) ...[
                                const SizedBox(height: _actionsGap),
                                const SkipVerificationButton(),
                              ],
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
    );
  }
}
