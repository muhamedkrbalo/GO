import 'package:flutter/material.dart';

import '../../theme/extensions/theme_extensions.dart';

class SelectionIndicator extends StatelessWidget {
  const SelectionIndicator({super.key, required this.isSelected, required this.duration});

  final bool isSelected;
  final Duration duration;

  static const _size = 20.0;
  static const _dotSize = 9.3;
  static const _borderWidth = 1.6;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return AnimatedContainer(
      duration: duration,
      width: _size,
      height: _size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colors.surface,
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? colors.primary : colors.hint,
          width: _borderWidth,
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
