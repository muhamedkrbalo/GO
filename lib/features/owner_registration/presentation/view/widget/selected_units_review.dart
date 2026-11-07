import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/owner_unit.dart';
import '../../controller/ownership_details_cubit.dart';

class SelectedUnitsReview extends StatelessWidget {
  const SelectedUnitsReview({super.key, required this.units, required this.ownership});

  final List<OwnerUnit> units;
  final Map<String, UnitOwnership> ownership;

  static const _topPadding = EdgeInsetsDirectional.only(top: 10);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _topPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var index = 0; index < units.length; index++) ...[
            if (index > 0) AppSpacing.gapV10,
            _UnitReviewCard(
              unit: units[index],
              details: ownership[units[index].id] ?? const UnitOwnership(),
            ),
          ],
        ],
      ),
    );
  }
}

class _UnitReviewCard extends StatelessWidget {
  const _UnitReviewCard({required this.unit, required this.details});

  final OwnerUnit unit;
  final UnitOwnership details;

  static final _dateFormat = DateFormat('dd/MM/yyyy');
  static const _padding = EdgeInsetsDirectional.all(12);
  static const _radius = BorderRadius.all(Radius.circular(10));
  static const _badgePadding = EdgeInsetsDirectional.symmetric(horizontal: 6, vertical: 3);
  static const _locationGap = SizedBox(height: 4);
  static const _detailsGap = SizedBox(height: 10);
  static const _columnGap = SizedBox(width: 6);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final isComplete = details.isValid;
    final building = unit.building;
    final date = details.date;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.canvas,
        borderRadius: _radius,
        border: Border.all(color: colors.subtleBorder),
      ),
      child: Padding(
        padding: _padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    unit.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.xxxsBold.copyWith(
                      color: colors.textPrimary,
                      height: _textHeight,
                    ),
                  ),
                ),
                AppSpacing.gapH8,
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: isComplete ? colors.successSurface : colors.goldSurface,
                    borderRadius: AppRadius.brCircle,
                  ),
                  child: Padding(
                    padding: _badgePadding,
                    child: Text(
                      isComplete
                          ? AppLocaleKey.informationComplete.tr()
                          : AppLocaleKey.informationIncomplete.tr(),
                      style: AppTextStyles.xxxxxsMedium.copyWith(
                        color: isComplete ? colors.success : colors.goldLink,
                        fontWeight: FontWeight.w700,
                        height: _textHeight,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            _locationGap,
            Text(
              building == null ? unit.village : '$building · ${unit.village}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.xxxxxsMedium.copyWith(
                color: colors.textMuted,
                fontWeight: FontWeight.w400,
                height: _textHeight,
              ),
            ),
            _detailsGap,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _UnitDetail(
                    label: AppLocaleKey.ownershipType.tr(),
                    value: details.type?.labelKey.tr(),
                  ),
                ),
                _columnGap,
                Expanded(
                  child: _UnitDetail(
                    label: AppLocaleKey.ownershipDate.tr(),
                    value: date == null ? null : _dateFormat.format(date),
                  ),
                ),
                _columnGap,
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _UnitDetail extends StatelessWidget {
  const _UnitDetail({required this.label, required this.value});

  final String label;
  final String? value;

  static const _gap = SizedBox(height: 3);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Column(
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
          value ?? AppLocaleKey.notProvided.tr(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.xxxxxsMedium.copyWith(
            color: colors.formLabel,
            fontWeight: FontWeight.w700,
            height: _textHeight,
          ),
        ),
      ],
    );
  }
}
