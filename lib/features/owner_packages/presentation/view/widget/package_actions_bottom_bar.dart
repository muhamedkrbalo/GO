import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/buttons/primary_arrow_button.dart';
import '../../../../../core/custom_widgets/registration_form/registration_sticky_footer.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class PackageActionsBottomBar extends StatelessWidget {
  const PackageActionsBottomBar({
    super.key,
    required this.confirmLabel,
    required this.backLabel,
    required this.onConfirm,
    required this.onBack,
  });

  final String confirmLabel;
  final String backLabel;
  final VoidCallback? onConfirm;
  final VoidCallback onBack;

  static const _backButtonSize = Size(double.infinity, 38);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return RegistrationStickyFooter(
      showSaveAndExit: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PrimaryArrowButton(text: confirmLabel, isEnabled: true, onPressed: onConfirm),
          TextButton(
            onPressed: onBack,
            style: TextButton.styleFrom(
              minimumSize: _backButtonSize,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              foregroundColor: colors.textPrimary,
              textStyle: AppTextStyles.xxsBold.copyWith(height: _textHeight),
            ),
            child: Text(backLabel),
          ),
        ],
      ),
    );
  }
}
