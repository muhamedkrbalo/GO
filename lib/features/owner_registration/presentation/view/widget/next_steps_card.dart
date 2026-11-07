import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class NextStepsCard extends StatelessWidget {
  const NextStepsCard({super.key});

  static const _steps = [
    AppLocaleKey.nextStepReviewOwnerInfo,
    AppLocaleKey.nextStepReviewUnits,
    AppLocaleKey.nextStepNotification,
  ];

  static const _padding = EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 17);
  static const _radius = BorderRadius.all(Radius.circular(14));
  static const _titleGap = SizedBox(height: 14);
  static const _stepGap = SizedBox(height: 11);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: _radius,
        border: Border.all(color: colors.subtleBorder),
      ),
      child: Padding(
        padding: _padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocaleKey.yourNextSteps.tr(),
              style: AppTextStyles.xsBold.copyWith(color: colors.textPrimary, height: _textHeight),
            ),
            _titleGap,
            for (var index = 0; index < _steps.length; index++) ...[
              if (index > 0) _stepGap,
              _NextStep(number: index + 1, text: _steps[index].tr()),
            ],
          ],
        ),
      ),
    );
  }
}

class _NextStep extends StatelessWidget {
  const _NextStep({required this.number, required this.text});

  final int number;
  final String text;

  static const _circleSize = 24.0;
  static const _borderOpacity = 0.25;
  static const _numberHeight = 1.5;
  static const _textHeight = 1.45;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Row(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: colors.iconTileSurface,
            shape: BoxShape.circle,
            border: Border.all(color: colors.oceanAccent.withValues(alpha: _borderOpacity)),
          ),
          child: SizedBox.square(
            dimension: _circleSize,
            child: Center(
              child: Text(
                '$number',
                style: AppTextStyles.xxxxxsMedium.copyWith(
                  color: colors.oceanAccent,
                  fontWeight: FontWeight.w700,
                  height: _numberHeight,
                ),
              ),
            ),
          ),
        ),
        AppSpacing.gapH10,
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.xxxxsRegular.copyWith(
              color: colors.formLabel,
              height: _textHeight,
            ),
          ),
        ),
      ],
    );
  }
}
