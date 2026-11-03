import 'package:flutter/material.dart';

import '../../theme/extensions/theme_extensions.dart';

class RingBadge extends StatelessWidget {
  const RingBadge({
    super.key,
    this.size = 42,
    this.innerSize = 12,
    this.borderWidth = 1.6,
    this.innerBorderWidth = 1.6,
    this.outerOpacity = 0.5,
  });

  final double size;
  final double innerSize;
  final double borderWidth;
  final double innerBorderWidth;
  final double outerOpacity;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: colors.accentBar.withValues(alpha: outerOpacity),
          width: borderWidth,
        ),
      ),
      child: Container(
        width: innerSize,
        height: innerSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: colors.primary, width: innerBorderWidth),
        ),
      ),
    );
  }
}
