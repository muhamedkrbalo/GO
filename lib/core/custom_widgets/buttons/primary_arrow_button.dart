import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../images/app_images.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/extensions/theme_extensions.dart';
import 'custom_button.dart';

class PrimaryArrowButton extends StatelessWidget {
  const PrimaryArrowButton({
    super.key,
    required this.text,
    required this.isEnabled,
    required this.onPressed,
  });

  final String text;
  final bool isEnabled;
  final VoidCallback? onPressed;

  static const _height = 52.0;
  static const _radius = 12.0;
  static const _iconSize = 19.0;
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final foreground = isEnabled ? colors.onPrimary : colors.hint;

    return CustomButton(
      text: text,
      height: _height,
      radius: _radius,
      hasShadow: true,
      isEnabled: isEnabled,
      disabledColor: colors.subtleBorder,
      disabledBorderColor: colors.subtleBorder,
      style: AppTextStyles.sBold.copyWith(color: foreground, height: _textHeight),
      suffixIcon: Padding(
        padding: const EdgeInsetsDirectional.only(start: AppSpacing.xs5),
        child: SvgPicture.asset(
          AppImages.assetsSvgArrowForward,
          width: _iconSize,
          height: _iconSize,
          matchTextDirection: true,
          colorFilter: ColorFilter.mode(foreground, BlendMode.srcIn),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
