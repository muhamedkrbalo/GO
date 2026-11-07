import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/buttons/header_back_button.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class CenteredTitleHeader extends StatelessWidget {
  const CenteredTitleHeader({super.key, required this.title, this.trailing});

  final String title;
  final Widget? trailing;

  static const _height = 72.0;
  static const _padding = EdgeInsetsDirectional.only(start: 22, end: 20);
  static const _backgroundOpacity = 0.96;
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: _backgroundOpacity),
        border: Border(bottom: BorderSide(color: colors.subtleBorder)),
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: _height,
          child: Padding(
            padding: _padding,
            child: NavigationToolbar(
              leading: const HeaderBackButton(),
              middle: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.sBold.copyWith(color: colors.textPrimary, height: _textHeight),
              ),
              trailing: trailing,
            ),
          ),
        ),
      ),
    );
  }
}
