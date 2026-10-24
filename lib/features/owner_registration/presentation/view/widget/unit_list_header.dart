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

  static const _countRowHeight = 32.0;
  static const _toggleMinSize = Size(0, 32);

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: _countRowHeight,
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: BlocSelector<UnitSelectionCubit, UnitSelectionState, int>(
              selector: (state) => state.visibleUnits.length,
              builder: (context, count) => Text(
                AppLocaleKey.unitsFound.tr(args: ['$count']),
                style: AppTextStyles.xxxsMedium.copyWith(color: colors.textMuted),
              ),
            ),
          ),
        ),
        AppSpacing.gapV8,
        BlocSelector<UnitSelectionCubit, UnitSelectionState, (int, bool)>(
          selector: (state) => (state.selectedCount, state.showSelectedOnly),
          builder: (context, selection) {
            final (selectedCount, showSelectedOnly) = selection;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocaleKey.availableUnits.tr(),
                        style: AppTextStyles.sRegular.copyWith(color: colors.textSecondary),
                      ),
                      const SizedBox(height: AppSpacing.xxs2),
                      Text(
                        AppLocaleKey.unitsSelectedCount.tr(args: ['$selectedCount']),
                        style: AppTextStyles.xxxsRegular.copyWith(color: colors.textMuted),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: selectedCount == 0
                      ? null
                      : context.read<UnitSelectionCubit>().toggleShowSelectedOnly,
                  style: TextButton.styleFrom(
                    minimumSize: _toggleMinSize,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    foregroundColor: colors.accentText,
                    disabledForegroundColor: colors.hint,
                    textStyle: AppTextStyles.xxxsBold,
                  ),
                  child: Text(
                    showSelectedOnly
                        ? AppLocaleKey.viewAllUnits.tr()
                        : AppLocaleKey.viewSelectedUnits.tr(),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
