import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../images/app_images.dart';
import '../../theme/extensions/theme_extensions.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  static const _size = 44.0;
  static const _borderWidth = 1.6;
  static const _radius = BorderRadius.all(Radius.circular(12.8));

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Semantics(
      button: true,
      label: MaterialLocalizations.of(context).backButtonTooltip,
      child: Material(
        color: colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: _radius,
          side: BorderSide(color: colors.subtleBorder, width: _borderWidth),
        ),
        child: InkWell(
          borderRadius: _radius,
          onTap: onPressed ?? context.pop,
          child: SizedBox.square(
            dimension: _size,
            child: Center(
              child: SvgPicture.asset(
                AppImages.assetsSvgArrowBack,
                matchTextDirection: true,
                colorFilter: ColorFilter.mode(colors.textSecondary, BlendMode.srcIn),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
