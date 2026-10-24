import 'package:flutter/material.dart';

import '../../../../../core/theme/extensions/theme_extensions.dart';

class SplashRing extends StatelessWidget {
  const SplashRing({super.key, required this.size});

  final double size;

  static const _borderWidth = 1.6;
  static const _opacity = 0.34;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: context.customColors.goldAccent.withValues(alpha: _opacity),
          width: _borderWidth,
        ),
      ),
    );
  }
}
