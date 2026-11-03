import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../images/app_images.dart';
import '../../theme/extensions/theme_extensions.dart';

class HeaderBackButton extends StatelessWidget {
  const HeaderBackButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  static const _slotWidth = 34.0;
  static const _tapSize = 44.0;
  static const _offset = -10.0;
  static const _iconSize = 21.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return SizedBox(
      width: _slotWidth,
      height: _tapSize,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          PositionedDirectional(
            start: _offset,
            top: 0,
            child: Semantics(
              button: true,
              label: MaterialLocalizations.of(context).backButtonTooltip,
              child: InkResponse(
                onTap: onPressed ?? context.pop,
                radius: _tapSize / 2,
                child: SizedBox.square(
                  dimension: _tapSize,
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
          ),
        ],
      ),
    );
  }
}
