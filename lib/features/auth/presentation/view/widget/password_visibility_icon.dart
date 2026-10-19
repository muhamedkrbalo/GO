import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class PasswordVisibilityIcon extends StatelessWidget {
  const PasswordVisibilityIcon({super.key, required this.isObscured});

  final bool isObscured;

  static const _size = 20.0;
  static const _tapArea = 51.0;

  @override
  Widget build(BuildContext context) {
    final color = context.customColors.textMuted;

    return SizedBox.square(
      dimension: _tapArea,
      child: Center(
        child: isObscured
            ? SvgPicture.asset(
                AppImages.assetsSvgEye,
                width: _size,
                height: _size,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              )
            : Icon(Icons.visibility_off_outlined, size: _size, color: color),
      ),
    );
  }
}
