import 'package:flutter/material.dart';

import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class DocumentSectionHeader extends StatelessWidget {
  const DocumentSectionHeader({
    super.key,
    required this.number,
    required this.title,
    required this.subtitle,
  });

  final int number;
  final String title;
  final String subtitle;

  static const _badgeSize = 26.4;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(color: colors.primary, borderRadius: AppRadius.brS),
          child: SizedBox.square(
            dimension: _badgeSize,
            child: Center(
              child: Text(
                '$number',
                style: AppTextStyles.xxsBold.copyWith(color: colors.onPrimary),
              ),
            ),
          ),
        ),
        AppSpacing.gapH10,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.sRegular.copyWith(color: colors.textSecondary)),
              const SizedBox(height: AppSpacing.xxs2),
              Text(
                subtitle,
                style: AppTextStyles.xxxsRegular.copyWith(color: colors.textMuted, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
