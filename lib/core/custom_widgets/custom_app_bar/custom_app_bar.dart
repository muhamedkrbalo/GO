import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../images/app_images.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/extensions/theme_extensions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.showBackButton = true,
    this.onBack,
    this.backgroundColor,
    this.showBottomBorder = true,
    this.height = defaultHeight,
  });

  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onBack;
  final Color? backgroundColor;
  final bool showBottomBorder;
  final double height;

  static const defaultHeight = 72.0;
  static const _leadingStartPadding = 13.0;
  static const _backButtonSize = 42.0;
  static const _actionsEndPadding = EdgeInsetsDirectional.only(end: 13);
  static const _titleHeight = 1.5;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final title = this.title;
    final actions = this.actions;

    return AppBar(
      toolbarHeight: height,
      backgroundColor: backgroundColor ?? colors.appBar,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leadingWidth: showBackButton ? _leadingStartPadding + _backButtonSize : null,
      leading: showBackButton
          ? Padding(
              padding: const EdgeInsetsDirectional.only(start: _leadingStartPadding),
              child: _AppBarBackButton(size: _backButtonSize, onPressed: onBack),
            )
          : null,
      title:
          titleWidget ??
          (title == null
              ? null
              : Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.sBold.copyWith(
                    color: colors.textPrimary,
                    height: _titleHeight,
                  ),
                )),
      actions: actions == null ? null : [...actions, const Padding(padding: _actionsEndPadding)],
      shape: showBottomBorder ? Border(bottom: BorderSide(color: colors.subtleBorder)) : null,
    );
  }
}

class _AppBarBackButton extends StatelessWidget {
  const _AppBarBackButton({required this.size, this.onPressed});

  final double size;
  final VoidCallback? onPressed;

  static const _iconSize = 20.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Center(
      child: SizedBox.square(
        dimension: size,
        child: IconButton(
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          padding: EdgeInsets.zero,
          onPressed: onPressed ?? () => Navigator.maybePop(context),
          icon: Transform.flip(
            flipX: true,
            child: SvgPicture.asset(
              AppImages.assetsSvgArrowForward,
              width: _iconSize,
              height: _iconSize,
              matchTextDirection: true,
              colorFilter: ColorFilter.mode(colors.accentText, BlendMode.srcIn),
            ),
          ),
        ),
      ),
    );
  }
}
