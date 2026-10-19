import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class RegisterStepIndicator extends StatelessWidget {
  const RegisterStepIndicator({super.key, required this.step, required this.stepCount});

  final int step;
  final int stepCount;


  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final labelStyle = AppTextStyles.xxsBold.copyWith(
      color: colors.textMuted,
      letterSpacing: 1.2,
      height: 1.4,
    );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppLocaleKey.accountCreation.tr(), style: labelStyle),
            Text(AppLocaleKey.stepOf.tr(args: ['$step', '$stepCount']), style: labelStyle),
          ],
        ),
        AppSpacing.gapV8,
        Row(
          spacing: 6.4,
          children: [
            for (var i = 1; i <= stepCount; i++)
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: i <= step ? colors.primary : colors.subtleBorder,
                    borderRadius: AppRadius.brCircle,
                  ),
                  child: const SizedBox(height: 4.0),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
