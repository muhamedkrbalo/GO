import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class HaveAccountPrompt extends StatelessWidget {
  const HaveAccountPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocaleKey.haveAnAccount.tr(),
          style: AppTextStyles.xs13Regular.copyWith(color: colors.textMuted),
        ),
        AppSpacing.gapH5,
        TextButton(
          onPressed: () => context.pushReplacementNamed(RouteNames.login),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            foregroundColor: colors.accentText,
            textStyle: AppTextStyles.xs13Bold,
          ),
          child: Text(AppLocaleKey.logIn.tr()),
        ),
      ],
    );
  }
}
