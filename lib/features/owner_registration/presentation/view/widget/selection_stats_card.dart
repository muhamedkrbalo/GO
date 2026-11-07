import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/selected_units_review_cubit.dart';

class SelectionStatsCard extends StatelessWidget {
  const SelectionStatsCard({super.key});

  static const _radius = BorderRadius.all(Radius.circular(13));
  static const _wideFlex = 5;
  static const _narrowFlex = 4;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: _radius,
        border: Border.all(color: colors.subtleBorder),
        boxShadow: AppShadows.sectionCard,
      ),
      child: BlocSelector<SelectedUnitsReviewCubit, SelectedUnitsReviewState, (int, int, int)>(
        selector: (state) => (state.unitCount, state.villageCount, state.buildingCount),
        builder: (context, stats) {
          final (units, villages, buildings) = stats;
          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: _wideFlex,
                  child: _StatCell(
                    value: units,
                    label: AppLocaleKey.totalSelectedUnits.tr(),
                    hasDivider: true,
                  ),
                ),
                Expanded(
                  flex: _narrowFlex,
                  child: _StatCell(
                    value: villages,
                    label: AppLocaleKey.villages.tr(),
                    hasDivider: true,
                  ),
                ),
                Expanded(
                  flex: _narrowFlex,
                  child: _StatCell(value: buildings, label: AppLocaleKey.buildings.tr()),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell({required this.value, required this.label, this.hasDivider = false});

  final int value;
  final String label;
  final bool hasDivider;

  static const _padding = EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 10);
  static const _minHeight = 68.0;
  static const _gap = SizedBox(height: 4);
  static const _valueHeight = 1.5;
  static const _labelHeight = 1.25;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: hasDivider ? BorderDirectional(end: BorderSide(color: colors.subtleBorder)) : null,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: _minHeight),
        child: Padding(
          padding: _padding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$value',
                style: AppTextStyles.xlBold.copyWith(
                  color: colors.textPrimary,
                  height: _valueHeight,
                ),
              ),
              _gap,
              Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.xxxxxsMedium.copyWith(
                  color: colors.textMuted,
                  fontWeight: FontWeight.w600,
                  height: _labelHeight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
