import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class DocumentsNotice extends StatelessWidget {
  const DocumentsNotice({super.key});

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
          AppLocaleKey.documentsReviewNotice.tr(),
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
