import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class SubmissionConfirmationHeader extends StatelessWidget {
  const SubmissionConfirmationHeader({super.key});

  static const _padding = EdgeInsetsDirectional.fromSTEB(24, 14, 24, 8);
  static const _minHeight = 54.0;
  static const _backgroundOpacity = 0.95;
  static const _borderOpacity = 0.8;
  static const _logoWidth = 84.0;
  static const _logoHeight = 56.0;
  static const _titleLetterSpacing = 0.6;
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.canvas.withValues(alpha: _backgroundOpacity),
        border: Border(
          bottom: BorderSide(color: colors.subtleBorder.withValues(alpha: _borderOpacity)),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: _padding,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: _minHeight),
            child: Row(
              children: [
                Image.asset(
                  AppImages.assetsImagesGoBrandLogo,
                  width: _logoWidth,
                  height: _logoHeight,
                  fit: BoxFit.cover,
                ),
                const Spacer(),
                Text(
                  AppLocaleKey.ownerRegistration.tr(),
                  style: AppTextStyles.xxxsBold.copyWith(
                    color: colors.textPrimary,
                    letterSpacing: _titleLetterSpacing,
                    height: _textHeight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
