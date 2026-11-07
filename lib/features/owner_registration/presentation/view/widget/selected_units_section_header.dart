import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class SelectedUnitsSectionHeader extends StatelessWidget {
  const SelectedUnitsSectionHeader({super.key});

  static const _textHeight = 1.5;
  static const _captionLetterSpacing = 0.32;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Row(
      children: [
        Expanded(
          child: Text(
            AppLocaleKey.selectedUnits.tr(),
            style: AppTextStyles.xs13Bold.copyWith(color: colors.textPrimary, height: _textHeight),
          ),
        ),
        AppSpacing.gapH12,
        Text(
          AppLocaleKey.prototypeSampleData.tr().toUpperCase(),
          style: AppTextStyles.xxxxxsMedium.copyWith(
            color: colors.hint,
            fontWeight: FontWeight.w600,
            letterSpacing: _captionLetterSpacing,
            height: _textHeight,
          ),
        ),
      ],
    );
  }
}
