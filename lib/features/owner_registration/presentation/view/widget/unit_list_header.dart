import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/unit_selection_cubit.dart';

class UnitListHeader extends StatelessWidget {
  const UnitListHeader({super.key});

  static const _textHeight = 1.5;
  static const _captionLetterSpacing = 0.4;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocaleKey.availableUnits.tr(),
                style: AppTextStyles.sBold.copyWith(color: colors.textPrimary, height: _textHeight),
              ),
              const SizedBox(height: AppSpacing.xxs2),
              Text(
                AppLocaleKey.prototypeSampleData.tr().toUpperCase(),
                style: AppTextStyles.xxxxxsMedium.copyWith(
                  color: colors.hint,
                  letterSpacing: _captionLetterSpacing,
                  height: _textHeight,
                ),
              ),
            ],
          ),
        ),
        AppSpacing.gapH12,
        BlocSelector<UnitSelectionCubit, UnitSelectionState, int>(
          selector: (state) => state.visibleUnits.length,
          builder: (context, count) => Text(
            AppLocaleKey.resultsCount.tr(args: ['$count']),
            style: AppTextStyles.xxxxsMedium.copyWith(
              color: colors.textMuted,
              fontWeight: FontWeight.w600,
              height: _textHeight,
            ),
          ),
        ),
      ],
    );
  }
}
