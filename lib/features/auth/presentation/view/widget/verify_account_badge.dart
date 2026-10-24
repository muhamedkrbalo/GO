import 'package:flutter/material.dart';

import '../../../../../core/theme/extensions/theme_extensions.dart';

class VerifyAccountBadge extends StatelessWidget {
  const VerifyAccountBadge({super.key});

  static const _size = 42.0;
  static const _innerSize = 12.0;
  static const _borderWidth = 1.6;
  static const _outerOpacity = 0.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Container(
      width: _size,
      height: _size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: colors.accentBar.withValues(alpha: _outerOpacity),
          width: _borderWidth,
        ),
      ),
      child: Container(
        width: _innerSize,
        height: _innerSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: colors.primary, width: _borderWidth),
        ),
      ),
    );
  }
}
