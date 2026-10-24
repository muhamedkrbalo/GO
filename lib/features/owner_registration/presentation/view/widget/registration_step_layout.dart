import 'package:flutter/material.dart';

import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import 'registration_navigation_bar.dart';
import 'registration_progress_header.dart';

class RegistrationStepLayout extends StatelessWidget {
  const RegistrationStepLayout({
    super.key,
    required this.step,
    required this.progress,
    required this.completedLabel,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.child,
    this.onContinue,
  });

  final int step;
  final double progress;
  final String completedLabel;
  final String eyebrow;
  final String title;
  final String subtitle;
  final Widget child;
  final VoidCallback? onContinue;

  static const _contentPadding = EdgeInsets.fromLTRB(20, 24, 20, 24);

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Form(
      child: Scaffold(
        backgroundColor: colors.canvas,
        bottomNavigationBar: RegistrationNavigationBar(onContinue: onContinue),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              RegistrationProgressHeader(
                step: step,
                progress: progress,
                completedLabel: completedLabel,
              ),
              Expanded(
                child: ListView(
                  padding: _contentPadding,
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  children: [
                    Text(
                      eyebrow,
                      style: AppTextStyles.xxsBold.copyWith(
                        color: colors.textPrimary,
                        letterSpacing: 0.8,
                        height: 1.55,
                      ),
                    ),
                    AppSpacing.gapV8,
                    Text(
                      title,
                      style: AppTextStyles.xxlBold.copyWith(
                        color: colors.textSecondary,
                        letterSpacing: -1,
                        height: 1.2,
                      ),
                    ),
                    AppSpacing.gapV10,
                    Text(
                      subtitle,
                      style: AppTextStyles.sRegular.copyWith(color: colors.textMuted, height: 1.55),
                    ),
                    AppSpacing.gapV24,
                    child,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
