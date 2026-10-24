import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/bottom_sheet/option_picker_sheet.dart';
import '../../../../../core/extension/context_ui_extension.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../data/model/owner_unit.dart';
import '../../controller/unit_selection_cubit.dart';
import 'unit_filter_dropdown.dart';

class UnitFilters extends StatelessWidget {
  const UnitFilters({super.key});

  Future<T?> _pick<T>(
    BuildContext context, {
    required String title,
    required List<T> options,
    required String Function(T option) labelOf,
    T? selected,
  }) {
    return context.showAppBottomSheet<T>(
      OptionPickerSheet<T>(title: title, options: options, labelOf: labelOf, selected: selected),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UnitSelectionCubit>();

    return Row(
      children: [
        Expanded(
          child: BlocSelector<UnitSelectionCubit, UnitSelectionState, String?>(
            selector: (state) => state.village,
            builder: (context, village) => UnitFilterDropdown(
              hint: AppLocaleKey.village.tr(),
              value: village,
              onClear: () => cubit.setVillage(null),
              onTap: () async {
                final picked = await _pick<String>(
                  context,
                  title: AppLocaleKey.village.tr(),
                  options: cubit.state.villages,
                  labelOf: (village) => village,
                  selected: village,
                );
                if (picked != null) cubit.setVillage(picked);
              },
            ),
          ),
        ),
        AppSpacing.gapH8,
        Expanded(
          child: BlocSelector<UnitSelectionCubit, UnitSelectionState, String?>(
            selector: (state) => state.building,
            builder: (context, building) => UnitFilterDropdown(
              hint: AppLocaleKey.building.tr(),
              value: building,
              onClear: () => cubit.setBuilding(null),
              onTap: () async {
                final picked = await _pick<String>(
                  context,
                  title: AppLocaleKey.building.tr(),
                  options: cubit.state.buildings,
                  labelOf: (building) => building,
                  selected: building,
                );
                if (picked != null) cubit.setBuilding(picked);
              },
            ),
          ),
        ),
        AppSpacing.gapH8,
        Expanded(
          child: BlocSelector<UnitSelectionCubit, UnitSelectionState, UnitType?>(
            selector: (state) => state.unitType,
            builder: (context, unitType) => UnitFilterDropdown(
              hint: AppLocaleKey.unitType.tr(),
              value: unitType?.labelKey.tr(),
              onClear: () => cubit.setUnitType(null),
              onTap: () async {
                final picked = await _pick<UnitType>(
                  context,
                  title: AppLocaleKey.unitType.tr(),
                  options: UnitType.values,
                  labelOf: (type) => type.labelKey.tr(),
                  selected: unitType,
                );
                if (picked != null) cubit.setUnitType(picked);
              },
            ),
          ),
        ),
      ],
    );
  }
}
