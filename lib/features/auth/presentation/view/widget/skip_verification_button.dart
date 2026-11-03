import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class SkipVerificationButton extends StatelessWidget {
  const SkipVerificationButton({super.key});

  static const _minSize = Size(64, 44);
  static const _padding = EdgeInsetsDirectional.symmetric(horizontal: 10);
  static const _height = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return TextButton(
      onPressed: () => context.goNamed(RouteNames.businessRole),
      style: TextButton.styleFrom(
        minimumSize: _minSize,
        padding: _padding,
        foregroundColor: colors.goldLink,
        textStyle: AppTextStyles.xxsSemiBold.copyWith(
          height: _height,
          decoration: TextDecoration.underline,
          decorationColor: colors.goldLink,
        ),
      ),
      child: Text(AppLocaleKey.skipVerificationPrototype.tr(), textAlign: TextAlign.center),
    );
  }
}
