import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class OwnerHomeCardLink extends StatelessWidget {
  const OwnerHomeCardLink({super.key, required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  static const _topGap = 11.0;
  static const _padding = EdgeInsetsDirectional.only(top: 10);
  static const _borderWidth = 1.5;
  static const _iconSize = 18.0;
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Padding(
      padding: const EdgeInsetsDirectional.only(top: _topGap),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: colors.selectedSurface, width: _borderWidth),
          ),
        ),
        child: Semantics(
          button: true,
          enabled: onTap != null,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: _padding,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      label,
                      style: AppTextStyles.xxxxsBold.copyWith(
                        color: colors.oceanAccent,
                        fontWeight: FontWeight.w800,
                        height: _textHeight,
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    AppImages.assetsSvgArrowForward,
                    width: _iconSize,
                    height: _iconSize,
                    matchTextDirection: true,
                    colorFilter: ColorFilter.mode(colors.oceanAccent, BlendMode.srcIn),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
