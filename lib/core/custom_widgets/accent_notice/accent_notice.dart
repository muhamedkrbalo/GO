import 'package:flutter/material.dart';

import '../../theme/app_text_styles.dart';
import '../../theme/extensions/theme_extensions.dart';

class AccentNotice extends StatelessWidget {
  const AccentNotice({super.key, required this.message, this.textAlign});

  final String message;
  final TextAlign? textAlign;

  static const _padding = EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 10);
  static const _accentWidth = 2.0;
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.goldSurface,
        border: BorderDirectional(
          start: BorderSide(color: colors.accentBar, width: _accentWidth),
        ),
      ),
      child: Padding(
        padding: _padding,
        child: Text(
          message,
          textAlign: textAlign,
          style: AppTextStyles.xxxxxsMedium.copyWith(
            color: colors.textMuted,
            fontWeight: FontWeight.w400,
            height: _textHeight,
          ),
        ),
      ),
    );
  }
}
