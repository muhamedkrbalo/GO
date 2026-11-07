import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/bottom_sheet/option_picker_sheet.dart';
import '../../../../../core/extension/context_ui_extension.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/unit_selection_cubit.dart';
import 'unit_filter_dropdown.dart';
import 'unit_search_field.dart';

class UnitFilters extends StatelessWidget {
  const UnitFilters({super.key});

  static const _padding = EdgeInsetsDirectional.all(14);
  static const _radius = BorderRadius.all(Radius.circular(13));

  Future<String?> _pick(
    BuildContext context, {
    required String title,
    required List<String> options,
    String? selected,
  }) {
    return context.showAppBottomSheet<String>(
      OptionPickerSheet<String>(
        title: title,
        options: options,
        labelOf: (option) => option,
        selected: selected,
      ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final cubit = context.read<UnitSelectionCubit>();

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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: BlocSelector<UnitSelectionCubit, UnitSelectionState, String?>(
                    selector: (state) => state.village,
                    builder: (context, village) => UnitFilterDropdown(
                      label: AppLocaleKey.village.tr(),
                      hint: AppLocaleKey.allVillages.tr(),
                      value: village,
                      onClear: () => cubit.setVillage(null),
                      onTap: () async {
                        final picked = await _pick(
                          context,
                          title: AppLocaleKey.village.tr(),
                          options: cubit.state.villages,
                          selected: village,
                        );
                        if (picked != null) cubit.setVillage(picked);
                      },
                    ),
                  ),
                ),
                AppSpacing.gapH10,
                Expanded(
                  child: BlocSelector<UnitSelectionCubit, UnitSelectionState, String?>(
                    selector: (state) => state.building,
                    builder: (context, building) => UnitFilterDropdown(
                      label: AppLocaleKey.building.tr(),
                      hint: AppLocaleKey.selectBuilding.tr(),
                      value: building,
                      onClear: () => cubit.setBuilding(null),
                      onTap: () async {
                        final picked = await _pick(
                          context,
                          title: AppLocaleKey.building.tr(),
                          options: cubit.state.buildings,
                          selected: building,
                        );
                        if (picked != null) cubit.setBuilding(picked);
                      },
                    ),
                  ),
                ),
              ],
            ),
            AppSpacing.gapV10,
            const UnitSearchField(),
          ],
        ),
      ),
    );
  }
}
