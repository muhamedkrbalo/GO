import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/custom_widgets/app_logo/app_logo.dart';
import '../../../../../core/custom_widgets/buttons/app_back_button.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class OwnerRegistrationHeader extends StatelessWidget {
  const OwnerRegistrationHeader({super.key});

  static const _height = 56.0;
  static const _minTapSize = Size(44, 44);

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return SizedBox(
      height: _height,
      child: Row(
        children: [
          const Expanded(
            child: Align(alignment: AlignmentDirectional.centerStart, child: AppBackButton()),
          ),
          const AppLogo(),
          Expanded(
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                onPressed: () => context.goNamed(RouteNames.welcome),
                style: TextButton.styleFrom(
                  minimumSize: _minTapSize,
                  padding: EdgeInsets.zero,
                  foregroundColor: colors.accentText,
                  textStyle: AppTextStyles.xsBold,
                ),
                child: Text(AppLocaleKey.saveAndExit.tr()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
