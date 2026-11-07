import 'package:flutter/material.dart';

import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class InfoStripItem {
  const InfoStripItem({required this.label, required this.value, this.flex = 1});

  final String label;
  final String value;
  final int flex;
}

class RegistrationInfoStrip extends StatelessWidget {
  const RegistrationInfoStrip({
    super.key,
    required this.items,
    this.radius = 11,
    this.minHeight = 0,
    this.valueColor,
    this.isBordered = true,
  });

  final List<InfoStripItem> items;
  final double radius;
  final double minHeight;
  final Color? valueColor;
  final bool isBordered;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        border: isBordered ? Border.all(color: colors.subtleBorder) : null,
      ),
      child: Row(
        children: [
          for (var index = 0; index < items.length; index++)
            Expanded(
              flex: items[index].flex,
              child: _InfoCell(
                item: items[index],
                minHeight: minHeight,
                valueColor: valueColor ?? colors.formLabel,
                hasDivider: index < items.length - 1,
              ),
            ),
        ],
      ),
    );
  }
}

class _InfoCell extends StatelessWidget {
  const _InfoCell({
    required this.item,
    required this.minHeight,
    required this.valueColor,
    required this.hasDivider,
  });

  final InfoStripItem item;
  final double minHeight;
  final Color valueColor;
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
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: minHeight),
        child: Padding(
          padding: _padding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.label,
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
                item.value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.xxxxsBold.copyWith(color: valueColor, height: _textHeight),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
