import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class OwnerHomeIntro extends StatelessWidget {
  const OwnerHomeIntro({super.key});

  static const _tileSize = 48.0;
  static const _tileIconSize = 23.0;
  static const _tileRadius = BorderRadius.all(Radius.circular(14));
  static const _textMaxWidth = 265.0;
  static const _gap = SizedBox(width: 16);
  static const _titleGap = SizedBox(height: 5);
  static const _subtitleGap = SizedBox(height: 7);
  static const _eyebrowLetterSpacing = 1.12;
  static const _titleLetterSpacing = -0.875;
  static const _eyebrowHeight = 1.5;
  static const _titleHeight = 1.16;
  static const _subtitleHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Row(
      children: [
        Expanded(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: _textMaxWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocaleKey.ownerWorkspace.tr().toUpperCase(),
                  style: AppTextStyles.xxxxxsMedium.copyWith(
                    color: colors.oceanAccent,
                    fontWeight: FontWeight.w800,
                    letterSpacing: _eyebrowLetterSpacing,
                    height: _eyebrowHeight,
                  ),
                ),
                _titleGap,
                Text(
                  AppLocaleKey.welcomeOwner.tr(),
                  style: AppTextStyles.xl25Bold.copyWith(
                    color: colors.textPrimary,
                    letterSpacing: _titleLetterSpacing,
                    height: _titleHeight,
                  ),
                ),
                _subtitleGap,
                Text(
                  AppLocaleKey.ownerHomeDescription.tr(),
                  style: AppTextStyles.xxxsRegular.copyWith(
                    color: colors.textMuted,
                    height: _subtitleHeight,
                  ),
                ),
              ],
            ),
          ),
        ),
        _gap,
        ExcludeSemantics(
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: _tileRadius,
              gradient: LinearGradient(
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
                colors: [colors.oceanAccent, colors.cyanAccent],
              ),
              boxShadow: AppShadows.oceanTile,
            ),
            child: SizedBox.square(
              dimension: _tileSize,
              child: Center(
                child: SvgPicture.asset(
                  AppImages.assetsSvgNavHome,
                  width: _tileIconSize,
                  height: _tileIconSize,
                  colorFilter: ColorFilter.mode(colors.onPrimary, BlendMode.srcIn),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
