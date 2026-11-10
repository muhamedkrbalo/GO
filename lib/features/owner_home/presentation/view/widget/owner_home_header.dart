import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class OwnerHomeHeader extends StatelessWidget {
  const OwnerHomeHeader({super.key});

  static const _padding = EdgeInsetsDirectional.fromSTEB(20, 14, 20, 8);
  static const _minHeight = 76.0;
  static const _logoWidth = 86.0;
  static const _logoHeight = 57.0;
  static const _borderWidth = 1.5;
  static const _backgroundOpacity = 0.98;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final logoCacheWidth = (_logoWidth * MediaQuery.devicePixelRatioOf(context)).round();

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: _backgroundOpacity),
        border: Border(
          bottom: BorderSide(color: colors.subtleBorder, width: _borderWidth),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: _minHeight),
          child: Padding(
            padding: _padding,
            child: Row(
              children: [
                Image.asset(
                  AppImages.assetsImagesGoBrandLogo,
                  width: _logoWidth,
                  height: _logoHeight,
                  cacheWidth: logoCacheWidth,
                  fit: BoxFit.cover,
                ),
                const Spacer(),
                _HeaderIconButton(
                  icon: AppImages.assetsSvgBell,
                  tooltip: AppLocaleKey.viewNotifications.tr(),
                ),
                AppSpacing.gapH8,
                _HeaderIconButton(
                  icon: AppImages.assetsSvgNavMore,
                  tooltip: AppLocaleKey.openOwnerMenu.tr(),
                  onPressed: () => context.goNamed(RouteNames.ownerMore),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({required this.icon, required this.tooltip, this.onPressed});

  final String icon;
  final String tooltip;
  final VoidCallback? onPressed;

  static const _size = 38.0;
  static const _iconSize = 18.0;
  static const _borderWidth = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Tooltip(
      message: tooltip,
      child: Semantics(
        button: true,
        enabled: onPressed != null,
        label: tooltip,
        excludeSemantics: true,
        child: Material(
          color: colors.canvas,
          shape: CircleBorder(
            side: BorderSide(color: colors.subtleBorder, width: _borderWidth),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onPressed,
            child: SizedBox.square(
              dimension: _size,
              child: Center(
                child: SvgPicture.asset(
                  icon,
                  width: _iconSize,
                  height: _iconSize,
                  colorFilter: ColorFilter.mode(colors.textPrimary, BlendMode.srcIn),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
