import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class GoMonogramBadge extends StatelessWidget {
  const GoMonogramBadge({super.key});

  static const _size = 52.0;
  static const _letterSpacing = 1.04;
  static const _height = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Container(
      width: _size,
      height: _size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colors.logoBackground,
        shape: BoxShape.circle,
        border: Border.all(color: colors.accentBar),
        boxShadow: AppShadows.monogramBadge,
      ),
      child: Text(
        AppLocaleKey.goMonogram.tr(),
        textAlign: TextAlign.center,
        style: AppTextStyles.xs13SerifBold.copyWith(
          color: colors.textPrimary,
          letterSpacing: _letterSpacing,
          height: _height,
        ),
      ),
    );
  }
}
