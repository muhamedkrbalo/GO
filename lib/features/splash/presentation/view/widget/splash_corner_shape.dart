import 'package:flutter/material.dart';

import '../../../../../core/theme/extensions/theme_extensions.dart';

class SplashCornerShape extends StatelessWidget {
  const SplashCornerShape({super.key});

  static const _width = 118.0;
  static const _height = 210.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    return Container(
      width: _width,
      height: _height,
      decoration: BoxDecoration(
        borderRadius: const BorderRadiusDirectional.only(bottomStart: Radius.circular(_width)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [colors.brandGradientStart, colors.brandGradientEnd],
        ),
      ),
    );
  }
}
