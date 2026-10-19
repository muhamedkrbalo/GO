import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/owner_unit.dart';

class SelectedUnitsSummary extends StatelessWidget {
  const SelectedUnitsSummary({super.key, required this.units});

  final List<OwnerUnit> units;

  static const _padding = EdgeInsets.all(16);
  static const _radius = BorderRadius.all(Radius.circular(12));
  static const _borderWidth = 1.6;
  static const _editMinSize = Size(0, 32);
  static const _rowGap = SizedBox(height: 6.4);

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: _radius,
        border: Border.all(color: colors.subtleBorder, width: _borderWidth),
        boxShadow: AppShadows.softCard,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocaleKey.unitsSelectedCount.tr(args: ['${units.length}']),
                        style: AppTextStyles.xsBold.copyWith(
                          color: colors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxs2),
                      Text(
                        AppLocaleKey.detailsSavedPerUnit.tr(),
                        style: AppTextStyles.xxxsRegular.copyWith(color: colors.textMuted),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: context.pop,
                  style: TextButton.styleFrom(
                    minimumSize: _editMinSize,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    foregroundColor: colors.accentText,
                    textStyle: AppTextStyles.xxxsBold,
                  ),
                  child: Text(AppLocaleKey.editUnits.tr()),
                ),
              ],
            ),
            AppSpacing.gapV12,
            for (var i = 0; i < units.length; i++) ...[
              if (i > 0) _rowGap,
              _SelectedUnitRow(unit: units[i]),
            ],
          ],
        ),
      ),
    );
  }
}

class _SelectedUnitRow extends StatelessWidget {
  const _SelectedUnitRow({required this.unit});

  final OwnerUnit unit;

  static const _padding = EdgeInsets.symmetric(horizontal: 9.6, vertical: 8);
  static const _radius = BorderRadius.all(Radius.circular(8.8));

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(color: colors.canvas, borderRadius: _radius),
      child: Padding(
        padding: _padding,
        child: Row(
          children: [
            Text(unit.name, style: AppTextStyles.xxxsBold.copyWith(color: colors.textSecondary)),
            AppSpacing.gapH12,
            Expanded(
              child: Text(
                unit.location,
                textAlign: TextAlign.end,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.xxxsRegular.copyWith(color: colors.textMuted),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
