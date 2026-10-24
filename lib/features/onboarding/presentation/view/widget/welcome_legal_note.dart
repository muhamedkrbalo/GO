import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class WelcomeLegalNote extends StatelessWidget {
  const WelcomeLegalNote({super.key});

  static const _height = 1.65;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final linkStyle = TextStyle(
      color: colors.onDarkLink,
      decoration: TextDecoration.underline,
      decorationColor: colors.onDarkLink,
    );

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: '${AppLocaleKey.byContinuingYouAgree.tr()} '),
          TextSpan(text: AppLocaleKey.termsLink.tr(), style: linkStyle),
          TextSpan(text: ' ${AppLocaleKey.andConjunction.tr()} '),
          TextSpan(text: AppLocaleKey.privacyPolicy.tr(), style: linkStyle),
          const TextSpan(text: '.'),
        ],
      ),
      textAlign: TextAlign.center,
      style: AppTextStyles.xxxxsRegular.copyWith(color: colors.onDarkSubtle, height: _height),
    );
  }
}
