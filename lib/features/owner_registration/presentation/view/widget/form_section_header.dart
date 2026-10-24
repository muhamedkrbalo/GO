import 'package:flutter/material.dart';

import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class FormSectionHeader extends StatelessWidget {
  const FormSectionHeader({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.xsBold.copyWith(color: colors.textSecondary, height: 1.5)),
        AppSpacing.gapV5,
        Text(
          subtitle,
          style: AppTextStyles.xxsRegular.copyWith(color: colors.textMuted, height: 1.45),
        ),
      ],
    );
  }
}
