import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/custom_widgets/buttons/custom_button.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import 'registration_bottom_bar.dart';

class IndividualInfoBottomBar extends StatelessWidget {
  const IndividualInfoBottomBar({super.key});

  static const _buttonHeight = 51.2;
  static const _backMinSize = Size(64, 32);

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return RegistrationBottomBar(
      children: [
        CustomButton(
          text: AppLocaleKey.continue_.tr(),
          height: _buttonHeight,
          hasShadow: true,
          onPressed: () => Form.of(context).validate(),
        ),
        TextButton(
          onPressed: context.pop,
          style: TextButton.styleFrom(
            minimumSize: _backMinSize,
            foregroundColor: colors.accentText,
            textStyle: AppTextStyles.xsBold,
          ),
          child: Text(AppLocaleKey.back.tr()),
        ),
      ],
    );
  }
}
