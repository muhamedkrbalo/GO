import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/owner_unit.dart';
import '../../controller/ownership_details_cubit.dart';

class UnitInfoStrip extends StatelessWidget {
  const UnitInfoStrip({super.key});

  static const _radius = BorderRadius.all(Radius.circular(11));
  static const _wideFlex = 4;
  static const _narrowFlex = 3;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: _radius,
        border: Border.all(color: colors.subtleBorder),
      ),
      child: BlocSelector<OwnershipDetailsCubit, OwnershipDetailsState, OwnerUnit>(
        selector: (state) => state.activeUnit,
        builder: (context, unit) {
          final building = unit.building;
          return Row(
            children: [
              Expanded(
                flex: _wideFlex,
                child: _InfoCell(
                  label: AppLocaleKey.village.tr(),
                  value: unit.village,
                  hasDivider: true,
                ),
              ),
              if (building != null)
                Expanded(
                  flex: _wideFlex,
                  child: _InfoCell(
                    label: AppLocaleKey.building.tr(),
                    value: building,
                    hasDivider: true,
                  ),
                ),
              Expanded(
                flex: _narrowFlex,
                child: _InfoCell(label: AppLocaleKey.unit.tr(), value: unit.name),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _InfoCell extends StatelessWidget {
  const _InfoCell({required this.label, required this.value, this.hasDivider = false});

  final String label;
  final String value;
  final bool hasDivider;

  static const _padding = EdgeInsetsDirectional.all(11);
  static const _gap = SizedBox(height: 4);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: hasDivider ? BorderDirectional(end: BorderSide(color: colors.subtleBorder)) : null,
      ),
      child: Padding(
        padding: _padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.xxxxxsMedium.copyWith(
                color: colors.hint,
                fontWeight: FontWeight.w600,
                height: _textHeight,
              ),
            ),
            _gap,
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.xxxxsBold.copyWith(color: colors.formLabel, height: _textHeight),
            ),
          ],
        ),
      ),
    );
  }
}
