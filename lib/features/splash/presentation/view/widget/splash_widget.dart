import 'package:flutter/material.dart';

import '../../../../../core/theme/extensions/theme_extensions.dart';
import 'splash_corner_shape.dart';
import 'splash_loading_bar.dart';
import 'splash_logo_badge.dart';
import 'splash_ring.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({super.key});

  static const _logoToLoaderGap = 36.0;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.customColors.surfaceWarm,
      child: const Stack(
        fit: StackFit.expand,
        children: [
          PositionedDirectional(top: 0, end: 0, child: SplashCornerShape()),
          PositionedDirectional(start: -236, bottom: -90, child: SplashRing(size: 390)),
          PositionedDirectional(end: -126, bottom: 112, child: SplashRing(size: 190)),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SplashLogoBadge(),
                SizedBox(height: _logoToLoaderGap),
                SplashLoadingBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
