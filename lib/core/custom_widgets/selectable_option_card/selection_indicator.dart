import 'package:flutter/material.dart';

import '../../theme/extensions/theme_extensions.dart';

class SelectionIndicator extends StatelessWidget {
  const SelectionIndicator({
    super.key,
    required this.isSelected,
    required this.duration,
    this.size = 20.0,
    this.borderWidth = 1.6,
    this.idleBorderColor,
  });

  final bool isSelected;
  final Duration duration;
  final double size;
  final double borderWidth;
  final Color? idleBorderColor;

  static const _dotSize = 9.3;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return AnimatedContainer(
      duration: duration,
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colors.surface,
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? colors.primary : idleBorderColor ?? colors.hint,
          width: borderWidth,
        ),
      ),
      child: AnimatedScale(
        scale: isSelected ? 1 : 0,
        duration: duration,
        child: DecoratedBox(
          decoration: BoxDecoration(color: colors.primary, shape: BoxShape.circle),
          child: const SizedBox.square(dimension: _dotSize),
        ),
      ),
    );
  }
}
