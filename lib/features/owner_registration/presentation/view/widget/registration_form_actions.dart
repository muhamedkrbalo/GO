import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/custom_widgets/buttons/primary_arrow_button.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class RegistrationFormActions extends StatelessWidget {
  const RegistrationFormActions({super.key, required this.canContinue, required this.onContinue});

  final bool canContinue;
  final VoidCallback onContinue;

  static const _gap = 6.0;
  static const _minTapSize = Size(64, 44);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PrimaryArrowButton(
          text: AppLocaleKey.continue_.tr(),
          isEnabled: canContinue,
          onPressed: onContinue,
        ),
        const SizedBox(height: _gap),
        TextButton(
          onPressed: () => context.goNamed(RouteNames.welcome),
          style: TextButton.styleFrom(
            minimumSize: _minTapSize,
            foregroundColor: colors.textPrimary,
            textStyle: AppTextStyles.xsBold.copyWith(height: _textHeight),
          ),
          child: Text(AppLocaleKey.saveAndExit.tr()),
        ),
      ],
    );
  }
}
