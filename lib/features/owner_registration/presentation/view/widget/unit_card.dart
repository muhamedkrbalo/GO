import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/owner_unit.dart';
import 'unit_status_badge.dart';

class UnitCard extends StatelessWidget {
  const UnitCard({super.key, required this.unit, required this.isSelected, required this.onTap});

  final OwnerUnit unit;
  final bool isSelected;
  final VoidCallback onTap;

  static const _duration = Duration(milliseconds: 160);
  static const _padding = EdgeInsetsDirectional.all(14);
  static const _radius = BorderRadius.all(Radius.circular(13));
  static const _minHeight = 100.0;
  static const _disabledOpacity = 0.78;
  static const _checkboxTopOffset = EdgeInsetsDirectional.only(top: 1);

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final isSelectable = unit.status.isSelectable;

    final card = AnimatedContainer(
      duration: _duration,
      constraints: const BoxConstraints(minHeight: _minHeight),
      decoration: BoxDecoration(
        color: isSelected
            ? colors.selectedSurface
            : isSelectable
            ? colors.surface
            : colors.canvas,
        borderRadius: _radius,
        border: Border.all(color: isSelected ? colors.oceanAccent : colors.subtleBorder),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: isSelectable ? onTap : null,
          borderRadius: _radius,
          child: Padding(
            padding: _padding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: _checkboxTopOffset,
                  child: _UnitCheckbox(
                    isSelected: isSelected,
                    isEnabled: isSelectable,
                    duration: _duration,
                  ),
                ),
                AppSpacing.gapH12,
                Expanded(child: _UnitDetails(unit: unit)),
              ],
            ),
          ),
        ),
      ),
    );

    return Semantics(
      checked: isSelected,
      enabled: isSelectable,
      child: isSelectable ? card : Opacity(opacity: _disabledOpacity, child: card),
    );
  }
}

class _UnitDetails extends StatelessWidget {
  const _UnitDetails({required this.unit});

  final OwnerUnit unit;

  static const _rowGap = SizedBox(height: 6);
  static const _nameRowHeight = 20.0;
  static const _nameHeight = 1.5;
  static const _metaHeight = 1.35;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: _nameRowHeight,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  unit.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.xsBold.copyWith(
                    color: colors.textSecondary,
                    height: _nameHeight,
                  ),
                ),
              ),
              AppSpacing.gapH8,
              UnitStatusBadge(status: unit.status),
            ],
          ),
        ),
        _rowGap,
        _UnitLocation(building: unit.building, village: unit.village),
        _rowGap,
        Row(
          children: [
            Text(
              unit.type.labelKey.tr().toUpperCase(),
              style: AppTextStyles.xxxxxsMedium.copyWith(
                color: colors.oceanAccent,
                fontWeight: FontWeight.w700,
                height: _nameHeight,
              ),
            ),
            AppSpacing.gapH8,
            Expanded(
              child: Text(
                unit.status.descriptionKey.tr(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.xxxxxsMedium.copyWith(
                  color: colors.hint,
                  fontWeight: FontWeight.w400,
                  height: _metaHeight,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _UnitLocation extends StatelessWidget {
  const _UnitLocation({required this.building, required this.village});

  final String? building;
  final String village;

  static const _dotSize = 3.0;
  static const _dotGap = SizedBox(width: 6);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final style = AppTextStyles.xxxsSemiBold.copyWith(color: colors.formLabel, height: _textHeight);
    final building = this.building;

    return Row(
      children: [
        if (building != null) ...[
          Flexible(
            child: Text(building, maxLines: 1, overflow: TextOverflow.ellipsis, style: style),
          ),
          _dotGap,
          DecoratedBox(
            decoration: BoxDecoration(color: colors.accentBar, shape: BoxShape.circle),
            child: const SizedBox.square(dimension: _dotSize),
          ),
          _dotGap,
        ],
        Flexible(
          child: Text(village, maxLines: 1, overflow: TextOverflow.ellipsis, style: style),
        ),
      ],
    );
  }
}

class _UnitCheckbox extends StatelessWidget {
  const _UnitCheckbox({required this.isSelected, required this.isEnabled, required this.duration});

  final bool isSelected;
  final bool isEnabled;
  final Duration duration;

  static const _size = 22.0;
  static const _iconSize = 12.0;
  static const _radius = BorderRadius.all(Radius.circular(6));

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return AnimatedContainer(
      duration: duration,
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        color: isSelected
            ? colors.oceanAccent
            : isEnabled
            ? colors.surface
            : colors.subtleBorder,
        borderRadius: _radius,
        border: Border.all(color: isSelected ? colors.oceanAccent : colors.border),
      ),
      child: isSelected
          ? Center(
              child: SvgPicture.asset(
                AppImages.assetsSvgCheck,
                width: _iconSize,
                height: _iconSize,
                colorFilter: ColorFilter.mode(colors.onPrimary, BlendMode.srcIn),
              ),
            )
          : null,
    );
  }
}
