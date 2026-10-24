import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class WelcomeHero extends StatelessWidget {
  const WelcomeHero({super.key});

  static const _height = 402.0;
  static const _glowCenter = Alignment(0, -0.04);
  static const _glowRadius = 0.26;
  static const _glowOpacity = 0.25;
  static const _borderWidth = 1.6;
  static const _ringSize = 280.0;
  static const _ringTop = 61.0;
  static const _ringOpacity = 0.35;
  static const _ellipseWidth = 420.0;
  static const _ellipseHeight = 170.0;
  static const _ellipseAngle = -12 * math.pi / 180;
  static const _tealEllipseLeft = -220.0;
  static const _tealEllipseTop = 68.0;
  static const _tealEllipseOpacity = 0.3;
  static const _goldEllipseRight = -260.0;
  static const _goldEllipseTop = 120.0;
  static const _goldEllipseOpacity = 0.32;
  static const _curveLeft = 47.0;
  static const _curveTop = 322.0;
  static const _curveWidth = 420.0;
  static const _curveHeight = 210.0;
  static const _logoCardTop = 110.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    return SizedBox(
      height: _height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [colors.heroGradientStart, colors.heroGradientEnd],
          ),
        ),
        child: ClipRect(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: _glowCenter,
                      radius: _glowRadius,
                      colors: [
                        colors.highlight.withValues(alpha: _glowOpacity),
                        colors.highlight.withValues(alpha: 0),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: _ringTop,
                left: 0,
                right: 0,
                child: Center(
                  child: _Outline(
                    width: _ringSize,
                    height: _ringSize,
                    color: colors.goldAccent.withValues(alpha: _ringOpacity),
                  ),
                ),
              ),
              Positioned(
                left: _curveLeft,
                top: _curveTop,
                child: Container(
                  width: _curveWidth,
                  height: _curveHeight,
                  decoration: BoxDecoration(
                    color: colors.primary,
                    borderRadius: BorderRadius.circular(_curveHeight),
                  ),
                ),
              ),
              Positioned(
                left: _tealEllipseLeft,
                top: _tealEllipseTop,
                child: Transform.rotate(
                  angle: _ellipseAngle,
                  child: _Outline(
                    width: _ellipseWidth,
                    height: _ellipseHeight,
                    color: colors.highlight.withValues(alpha: _tealEllipseOpacity),
                  ),
                ),
              ),
              Positioned(
                right: _goldEllipseRight,
                top: _goldEllipseTop,
                child: Transform.rotate(
                  angle: _ellipseAngle,
                  child: _Outline(
                    width: _ellipseWidth,
                    height: _ellipseHeight,
                    color: colors.goldAccent.withValues(alpha: _goldEllipseOpacity),
                  ),
                ),
              ),
              const Positioned(
                top: _logoCardTop,
                left: 0,
                right: 0,
                child: Center(child: _LogoCard()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Outline extends StatelessWidget {
  const _Outline({required this.width, required this.height, required this.color});

  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height),
        border: Border.all(color: color, width: WelcomeHero._borderWidth),
      ),
    );
  }
}

class _LogoCard extends StatelessWidget {
  const _LogoCard();

  static const _width = 250.0;
  static const _padding = EdgeInsets.symmetric(horizontal: 12, vertical: 16);
  static const _radius = BorderRadius.all(Radius.circular(18));
  static const _opacity = 0.96;
  static const _logoWidth = 226.0;
  static const _logoHeight = 151.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      padding: _padding,
      decoration: BoxDecoration(
        color: context.customColors.logoBackground.withValues(alpha: _opacity),
        borderRadius: _radius,
        boxShadow: AppShadows.welcomeLogoCard,
      ),
      child: Image.asset(
        AppImages.assetsImagesGoBrandLogo,
        width: _logoWidth,
        height: _logoHeight,
        fit: BoxFit.cover,
      ),
    );
  }
}
