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
  static const _padding = EdgeInsets.all(12.8);
  static const _radius = BorderRadius.all(Radius.circular(12));
  static const _borderWidth = 1.6;
  static const _disabledOpacity = 0.72;
  static const _lineGap = SizedBox(height: 3.5);

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final isSelectable = unit.status.isSelectable;
    final reasonKey = unit.status.reasonKey;

    final card = AnimatedContainer(
      duration: _duration,
      decoration: BoxDecoration(
        color: isSelected ? colors.selectedSurface : colors.surface,
        borderRadius: _radius,
        border: Border.all(
          color: isSelected ? colors.primary : colors.subtleBorder,
          width: _borderWidth,
        ),
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
                _UnitCheckbox(isSelected: isSelected, isEnabled: isSelectable, duration: _duration),
                AppSpacing.gapH12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              unit.name,
                              style: AppTextStyles.xsBold.copyWith(
                                color: colors.textSecondary,
                                height: 1.3,
                              ),
                            ),
                          ),
                          UnitStatusBadge(status: unit.status),
                        ],
                      ),
                      _lineGap,
                      Text(
                        unit.location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.xxxsRegular.copyWith(color: colors.textMuted),
                      ),
                      _lineGap,
                      Text(
                        unit.type.labelKey.tr(),
                        style: AppTextStyles.xxxsSemiBold.copyWith(color: colors.accentText),
                      ),
                      if (reasonKey != null) ...[
                        _lineGap,
                        Text(
                          reasonKey.tr(),
                          style: AppTextStyles.xxxsRegular.copyWith(color: colors.warning),
                        ),
                      ],
                    ],
                  ),
                ),
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

class _UnitCheckbox extends StatelessWidget {
  const _UnitCheckbox({required this.isSelected, required this.isEnabled, required this.duration});

  final bool isSelected;
  final bool isEnabled;
  final Duration duration;

  static const _size = 19.2;
  static const _iconSize = 12.0;
  static const _borderWidth = 1.6;
  static const _radius = BorderRadius.all(Radius.circular(5.6));

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return AnimatedContainer(
      duration: duration,
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        color: isSelected
            ? colors.primary
            : isEnabled
            ? colors.surface
            : colors.canvas,
        borderRadius: _radius,
        border: Border.all(
          color: isSelected
              ? colors.primary
              : isEnabled
              ? colors.hint
              : colors.border,
          width: _borderWidth,
        ),
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
