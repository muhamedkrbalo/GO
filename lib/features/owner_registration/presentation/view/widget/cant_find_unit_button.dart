import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class CantFindUnitButton extends StatelessWidget {
  const CantFindUnitButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  static const _minSize = Size(0, 44);
  static const _padding = EdgeInsetsDirectional.symmetric(horizontal: 10);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Center(
      child: TextButton(
        onPressed: onPressed ?? () {},
        style: TextButton.styleFrom(
          minimumSize: _minSize,
          padding: _padding,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          foregroundColor: colors.oceanAccent,
          textStyle: AppTextStyles.xxsBold.copyWith(
            height: _textHeight,
            decoration: TextDecoration.underline,
            decorationColor: colors.oceanAccent,
          ),
        ),
        child: Text(AppLocaleKey.cantFindYourUnit.tr()),
      ),
    );
  }
}
