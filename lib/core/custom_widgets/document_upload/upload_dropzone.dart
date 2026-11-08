import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../images/app_images.dart';
import '../../locale/app_locale_key.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/extensions/theme_extensions.dart';
import '../dotted_decoration/dotted_decoration.dart';

class UploadDropzone extends StatelessWidget {
  const UploadDropzone({
    super.key,
    required this.onTap,
    this.showIconTile = true,
    this.iconSize = 18,
  });

  final VoidCallback onTap;
  final bool showIconTile;
  final double iconSize;

  static const _radius = BorderRadius.all(Radius.circular(10));
  static const _padding = EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 16);
  static const _dash = [4, 3];
  static const _tileSize = 34.0;
  static const _tileRadius = BorderRadius.all(Radius.circular(9));
  static const _titleGap = SizedBox(height: 8);
  static const _hintGap = SizedBox(height: 4);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Semantics(
      button: true,
      child: Material(
        color: colors.canvas,
        borderRadius: _radius,
        child: InkWell(
          onTap: onTap,
          borderRadius: _radius,
          child: DecoratedBox(
            position: DecorationPosition.foreground,
            decoration: DottedDecoration(
              shape: Shape.box,
              borderRadius: _radius,
              color: colors.border,
              dash: _dash,
            ),
            child: Padding(
              padding: _padding,
              child: Column(
                children: [
                  if (showIconTile)
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: colors.iconTileSurface,
                        borderRadius: _tileRadius,
                      ),
                      child: SizedBox.square(
                        dimension: _tileSize,
                        child: Center(child: _UploadIcon(size: iconSize)),
                      ),
                    )
                  else
                    _UploadIcon(size: iconSize),
                  _titleGap,
                  Text(
                    AppLocaleKey.uploadDocument.tr(),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.xxxsBold.copyWith(
                      color: colors.textPrimary,
                      height: _textHeight,
                    ),
                  ),
                  _hintGap,
                  Text(
                    AppLocaleKey.documentFormatsHint.tr(),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.xxxxxsMedium.copyWith(
                      color: colors.hint,
                      fontWeight: FontWeight.w400,
                      height: _textHeight,
                    ),
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

class _UploadIcon extends StatelessWidget {
  const _UploadIcon({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppImages.assetsSvgUploadTray,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(context.customColors.oceanAccent, BlendMode.srcIn),
    );
  }
}
