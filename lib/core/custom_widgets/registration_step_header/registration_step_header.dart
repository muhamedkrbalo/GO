import 'package:flutter/material.dart';

import '../../theme/app_sizes.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/extensions/theme_extensions.dart';
import '../buttons/header_back_button.dart';

class RegistrationStepHeader extends StatelessWidget {
  const RegistrationStepHeader({
    super.key,
    required this.title,
    required this.stepLabel,
    required this.progress,
    this.stepTitle,
    this.stepHint,
    this.onBack,
    this.progressColors,
  });

  final String title;
  final String stepLabel;
  final double progress;
  final String? stepTitle;
  final String? stepHint;
  final VoidCallback? onBack;
  final List<Color>? progressColors;

  static const _padding = EdgeInsetsDirectional.fromSTEB(24, 12, 24, 16);
  static const _backgroundOpacity = 0.95;
  static const _navHeight = 48.0;
  static const _titleSidePadding = 48.0;
  static const _barHeight = 3.0;
  static const _textHeight = 1.5;
  static const _stepLetterSpacing = 1.08;
  static const _stepTitleLetterSpacing = 0.4;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: _backgroundOpacity),
        border: Border(bottom: BorderSide(color: colors.subtleBorder)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: _padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: _navHeight,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: HeaderBackButton(onPressed: onBack),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.symmetric(horizontal: _titleSidePadding),
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.sBold.copyWith(
                          color: colors.textPrimary,
                          height: _textHeight,
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        stepLabel.toUpperCase(),
                        style: AppTextStyles.xxxxsBold.copyWith(
                          color: colors.stepLabel,
                          letterSpacing: _stepLetterSpacing,
                          height: _textHeight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (stepTitle != null && stepHint != null) ...[
                AppSpacing.gapV8,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      stepTitle!,
                      style: AppTextStyles.xxxsBold.copyWith(
                        color: colors.oceanAccent,
                        letterSpacing: _stepTitleLetterSpacing,
                        height: _textHeight,
                      ),
                    ),
                    Text(
                      stepHint!,
                      style: AppTextStyles.xxxxsMedium.copyWith(
                        color: colors.hint,
                        height: _textHeight,
                      ),
                    ),
                  ],
                ),
              ],
              AppSpacing.gapV8,
              ClipRRect(
                borderRadius: AppRadius.brCircle,
                child: SizedBox(
                  height: _barHeight,
                  child: ColoredBox(
                    color: colors.subtleBorder,
                    child: FractionallySizedBox(
                      alignment: AlignmentDirectional.centerStart,
                      widthFactor: progress,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: AppRadius.brCircle,
                          gradient: LinearGradient(
                            begin: AlignmentDirectional.centerStart,
                            end: AlignmentDirectional.centerEnd,
                            colors: progressColors ?? [colors.oceanAccent, colors.cyanAccent],
                          ),
                        ),
                      ),
                    ),
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
