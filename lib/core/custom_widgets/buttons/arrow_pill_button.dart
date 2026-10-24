import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../images/app_images.dart';
import '../../theme/app_shadows.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/extensions/theme_extensions.dart';
import 'custom_button.dart';

class ArrowPillButton extends StatelessWidget {
  const ArrowPillButton({super.key, required this.text, required this.onPressed, this.width});

  final String text;
  final VoidCallback onPressed;
  final double? width;

  static const _startPadding = 22.0;
  static const _endPadding = 6.0;
  static const _arrowCircleSize = 44.0;
  static const _arrowSize = 20.0;
  static const _letterSpacing = 0.13;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    return CustomButton(
      width: width,
      color: colors.primary,
      borderRadius: AppRadius.brCircle,
      hasShadow: true,
      boxShadow: AppShadows.pillButton,
      prefixIcon: null,
      suffixIcon: null,
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: _startPadding, end: _endPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.xsSemiBold.copyWith(
                  color: colors.onPrimary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: _letterSpacing,
                ),
              ),
            ),
            Container(
              width: _arrowCircleSize,
              height: _arrowCircleSize,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: AlignmentDirectional.topStart,
                  end: AlignmentDirectional.bottomEnd,
                  colors: [colors.goldGradientStart, colors.goldGradientEnd],
                ),
              ),
              child: SvgPicture.asset(
                AppImages.assetsSvgArrowForward,
                width: _arrowSize,
                height: _arrowSize,
                matchTextDirection: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
