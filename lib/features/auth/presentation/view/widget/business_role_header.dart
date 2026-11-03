import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class BusinessRoleHeader extends StatelessWidget {
  const BusinessRoleHeader({super.key});

  static const _minHeight = 80.0;
  static const _padding = EdgeInsetsDirectional.fromSTEB(24, 16, 24, 8);
  static const _backgroundOpacity = 0.94;
  static const _borderOpacity = 0.72;
  static const _logoWidth = 88.0;
  static const _logoHeight = 58.656;
  static const _titleLetterSpacing = 0.96;
  static const _titleHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Container(
      constraints: const BoxConstraints(minHeight: _minHeight),
      padding: _padding,
      decoration: BoxDecoration(
        color: colors.canvas.withValues(alpha: _backgroundOpacity),
        border: Border(
          bottom: BorderSide(color: colors.subtleBorder.withValues(alpha: _borderOpacity)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            AppImages.assetsImagesGoBrandLogo,
            width: _logoWidth,
            height: _logoHeight,
            fit: BoxFit.cover,
          ),
          Text(
            AppLocaleKey.joinGo.tr(),
            style: AppTextStyles.xsBold.copyWith(
              color: colors.textPrimary,
              letterSpacing: _titleLetterSpacing,
              height: _titleHeight,
            ),
          ),
        ],
      ),
    );
  }
}
