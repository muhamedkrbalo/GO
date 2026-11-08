import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/enum/address_type.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class AddressTypeSelector extends StatelessWidget {
  const AddressTypeSelector({super.key, required this.selected, required this.onSelect});

  final AddressType selected;
  final ValueChanged<AddressType> onSelect;

  static const _gap = 8.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final type in AddressType.values) ...[
          if (type.index > 0) const SizedBox(width: _gap),
          Expanded(
            child: _AddressTypeOption(
              label: type.labelKey.tr(),
              isSelected: type == selected,
              onTap: () => onSelect(type),
            ),
          ),
        ],
      ],
    );
  }
}

class _AddressTypeOption extends StatelessWidget {
  const _AddressTypeOption({required this.label, required this.isSelected, required this.onTap});

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  static const _minHeight = 42.0;
  static const _radius = BorderRadius.all(Radius.circular(9));
  static const _padding = EdgeInsetsDirectional.symmetric(horizontal: 8);
  static const _indicatorHeight = 2.0;
  static const _textHeight = 1.5;
  static const _duration = Duration(milliseconds: 180);

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Semantics(
      button: true,
      selected: isSelected,
      inMutuallyExclusiveGroup: true,
      child: AnimatedContainer(
        duration: _duration,
        constraints: const BoxConstraints(minHeight: _minHeight),
        decoration: BoxDecoration(
          color: isSelected ? colors.iconTileSurface : colors.canvas,
          borderRadius: _radius,
          border: Border.all(color: isSelected ? colors.oceanAccent : colors.subtleBorder),
        ),
        child: ClipRRect(
          borderRadius: _radius,
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: onTap,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: _padding,
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.xxxsSemiBold.copyWith(
                        color: isSelected ? colors.textPrimary : colors.textMuted,
                        height: _textHeight,
                      ),
                    ),
                  ),
                  if (isSelected)
                    PositionedDirectional(
                      start: 0,
                      end: 0,
                      bottom: 0,
                      child: SizedBox(
                        height: _indicatorHeight,
                        child: ColoredBox(color: colors.cyanAccent),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
