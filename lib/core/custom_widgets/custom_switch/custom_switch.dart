import 'package:flutter/material.dart';

import '../../theme/app_shadows.dart';
import '../../theme/app_sizes.dart';
import '../../theme/extensions/theme_extensions.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({super.key, required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool>? onChanged;

  static const _width = 42.0;
  static const _height = 24.0;
  static const _padding = EdgeInsets.all(3);
  static const _knobSize = 18.0;
  static const _duration = Duration(milliseconds: 180);

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Semantics(
      toggled: value,
      enabled: onChanged != null,
      child: GestureDetector(
        onTap: onChanged == null ? null : () => onChanged!(!value),
        child: AnimatedContainer(
          duration: _duration,
          width: _width,
          height: _height,
          padding: _padding,
          decoration: BoxDecoration(
            color: value ? colors.oceanAccent : colors.subtleBorder,
            borderRadius: AppRadius.brCircle,
          ),
          child: AnimatedAlign(
            duration: _duration,
            alignment: value ? AlignmentDirectional.centerEnd : AlignmentDirectional.centerStart,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: colors.onPrimary,
                shape: BoxShape.circle,
                boxShadow: AppShadows.switchKnob,
              ),
              child: const SizedBox.square(dimension: _knobSize),
            ),
          ),
        ),
      ),
    );
  }
}
