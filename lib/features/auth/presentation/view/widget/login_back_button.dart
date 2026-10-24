import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class LoginBackButton extends StatelessWidget {
  const LoginBackButton({super.key});

  static const _size = 44.0;
  static const _iconSize = 20.0;
  static const _borderWidth = 1.6;

  void _back(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(RoutePaths.welcome);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Semantics(
      button: true,
      label: MaterialLocalizations.of(context).backButtonTooltip,
      child: Material(
        color: colors.surfaceWarm,
        shape: CircleBorder(
          side: BorderSide(color: colors.subtleBorder, width: _borderWidth),
        ),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () => _back(context),
          child: SizedBox.square(
            dimension: _size,
            child: Center(
              child: Transform.flip(
                flipX: true,
                child: SvgPicture.asset(
                  AppImages.assetsSvgArrowForward,
                  width: _iconSize,
                  height: _iconSize,
                  matchTextDirection: true,
                  colorFilter: ColorFilter.mode(colors.accentText, BlendMode.srcIn),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
