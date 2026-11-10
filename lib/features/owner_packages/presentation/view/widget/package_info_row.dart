import 'package:flutter/material.dart';

import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class PackageInfoRow extends StatelessWidget {
  const PackageInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.showDivider = false,
    this.isHighlighted = false,
    this.padding = const EdgeInsetsDirectional.symmetric(vertical: 9),
    this.minHeight = 0,
  });

  final String label;
  final String value;
  final bool showDivider;
  final bool isHighlighted;
  final EdgeInsetsGeometry padding;
  final double minHeight;

  static const _dividerWidth = 1.6;
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final valueStyle = isHighlighted ? AppTextStyles.xxsBold : AppTextStyles.xxxxxsMedium;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isHighlighted ? colors.iconTileSurface : null,
        border: showDivider
            ? Border(
                bottom: BorderSide(color: colors.surfaceVariant, width: _dividerWidth),
              )
            : null,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: minHeight),
        child: Padding(
          padding: padding,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.xxxxxsMedium.copyWith(
                    color: colors.textMuted,
                    fontWeight: FontWeight.w400,
                    height: _textHeight,
                  ),
                ),
              ),
              AppSpacing.gapH8,
              Text(
                value,
                textAlign: TextAlign.end,
                style: valueStyle.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w700,
                  height: _textHeight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
