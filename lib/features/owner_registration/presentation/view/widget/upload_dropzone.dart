import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/custom_widgets/dotted_decoration/dotted_decoration.dart';
import '../../../../../core/images/app_images.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class UploadDropzone extends StatelessWidget {
  const UploadDropzone({super.key, required this.onTap});

  final VoidCallback onTap;

  static const _height = 40.8;
  static const _radius = BorderRadius.all(Radius.circular(10.4));
  static const _borderWidth = 1.6;
  static const _dash = [5, 4];
  static const _iconSize = 16.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Material(
      color: colors.selectedSurface,
      borderRadius: _radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: _radius,
        child: DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: DottedDecoration(
            shape: Shape.box,
            borderRadius: _radius,
            color: colors.hint,
            dash: _dash,
            strokeWidth: _borderWidth,
          ),
          child: SizedBox(
            height: _height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppImages.assetsSvgUpload,
                  width: _iconSize,
                  height: _iconSize,
                  colorFilter: ColorFilter.mode(colors.accentText, BlendMode.srcIn),
                ),
                AppSpacing.gapH5,
                Text(
                  AppLocaleKey.uploadDocument.tr(),
                  style: AppTextStyles.xxxsBold.copyWith(color: colors.accentText),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
