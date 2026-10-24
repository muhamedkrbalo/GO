import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class CodeSentBanner extends StatelessWidget {
  const CodeSentBanner({super.key});

  static const _padding = EdgeInsets.symmetric(horizontal: 14, vertical: 12);
  static const _radius = BorderRadius.all(Radius.circular(7));
  static const _borderWidth = 1.6;
  static const _textHeight = 1.4;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Semantics(
      liveRegion: true,
      child: ClipRRect(
        borderRadius: _radius,
        child: Container(
          width: double.infinity,
          padding: _padding,
          decoration: BoxDecoration(
            color: colors.successSurface,
            border: BorderDirectional(
              start: BorderSide(color: colors.successBorder, width: _borderWidth),
            ),
          ),
          child: Text(
            AppLocaleKey.codeSentContinuing.tr(),
            style: AppTextStyles.xxsBold.copyWith(
              color: colors.success,
              fontWeight: FontWeight.w600,
              height: _textHeight,
            ),
          ),
        ),
      ),
    );
  }
}
