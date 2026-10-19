import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class RegistrationStepCard extends StatelessWidget {
  const RegistrationStepCard({
    super.key,
    required this.step,
    required this.title,
    required this.subtitle,
  });

  final int step;
  final String title;
  final String subtitle;

  static const _padding = EdgeInsets.symmetric(horizontal: 16, vertical: 14.4);
  static const _badgePadding = EdgeInsets.symmetric(horizontal: 8.8, vertical: 6);
  static const _radius = BorderRadius.all(Radius.circular(14.4));
  static const _borderWidth = 1.6;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: _radius,
        border: Border.all(color: colors.subtleBorder, width: _borderWidth),
      ),
      child: Padding(
        padding: _padding,
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(color: colors.primaryLight, borderRadius: AppRadius.brS),
              child: Padding(
                padding: _badgePadding,
                child: Text(
                  AppLocaleKey.stepNumber.tr(args: ['$step']),
                  style: AppTextStyles.xxsBold.copyWith(color: colors.accentText, height: 1.5),
                ),
              ),
            ),
            AppSpacing.gapH12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.xsBold.copyWith(color: colors.textSecondary, height: 1.35),
                  ),
                  const SizedBox(height: AppSpacing.xxs2),
                  Text(
                    subtitle,
                    style: AppTextStyles.xxsRegular.copyWith(color: colors.textMuted, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
