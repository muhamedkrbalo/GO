import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/unit_selection_cubit.dart';
import 'unit_card.dart';

class UnitListSliver extends StatelessWidget {
  const UnitListSliver({super.key});

  static const _padding = EdgeInsets.symmetric(horizontal: 20);
  static const _emptyPadding = EdgeInsets.symmetric(vertical: 32);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UnitSelectionCubit>();

    return BlocBuilder<UnitSelectionCubit, UnitSelectionState>(
      buildWhen: (previous, current) => !listEquals(previous.visibleUnits, current.visibleUnits),
      builder: (context, state) {
        final units = state.visibleUnits;
        return SliverPadding(
          padding: _padding,
          sliver: units.isEmpty
              ? SliverToBoxAdapter(
                  child: Padding(
                    padding: _emptyPadding,
                    child: Text(
                      AppLocaleKey.noUnitsFound.tr(),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.xsMedium.copyWith(color: context.customColors.textMuted),
                    ),
                  ),
                )
              : SliverList.separated(
                  itemCount: units.length,
                  separatorBuilder: (_, _) => AppSpacing.gapV10,
                  itemBuilder: (context, index) {
                    final unit = units[index];
                    return BlocSelector<UnitSelectionCubit, UnitSelectionState, bool>(
                      key: ValueKey(unit.id),
                      selector: (state) => state.selectedIds.contains(unit.id),
                      builder: (context, isSelected) => UnitCard(
                        unit: unit,
                        isSelected: isSelected,
                        onTap: () => cubit.toggleUnit(unit),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
