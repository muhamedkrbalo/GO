import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/owner_unit.dart';
import '../../controller/selected_units_review_cubit.dart';
import 'selected_unit_review_card.dart';

class SelectedUnitsReviewSliver extends StatelessWidget {
  const SelectedUnitsReviewSliver({super.key});

  static const _emptyPadding = EdgeInsetsDirectional.symmetric(vertical: 32);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SelectedUnitsReviewCubit>();

    return BlocSelector<SelectedUnitsReviewCubit, SelectedUnitsReviewState, List<OwnerUnit>>(
      selector: (state) => state.units,
      builder: (context, units) {
        if (units.isEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: _emptyPadding,
              child: Text(
                AppLocaleKey.noSelectedUnits.tr(),
                textAlign: TextAlign.center,
                style: AppTextStyles.xsMedium.copyWith(color: context.customColors.textMuted),
              ),
            ),
          );
        }
        return SliverList.separated(
          itemCount: units.length,
          separatorBuilder: (_, _) => AppSpacing.gapV12,
          itemBuilder: (context, index) {
            final unit = units[index];
            return SelectedUnitReviewCard(
              key: ValueKey(unit.id),
              unit: unit,
              onRemove: () => cubit.remove(unit),
            );
          },
        );
      },
    );
  }
}
