import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/custom_widgets/buttons/primary_arrow_button.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import 'registration_sticky_footer.dart';

class SubmissionConfirmationBottomBar extends StatelessWidget {
  const SubmissionConfirmationBottomBar({super.key, this.onViewStatus});

  final VoidCallback? onViewStatus;

  static const _homeMinSize = Size(0, 44);
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
          PrimaryArrowButton(
            text: AppLocaleKey.viewRegistrationStatus.tr(),
            isEnabled: true,
            onPressed: onViewStatus,
          ),
          TextButton(
            onPressed: () => context.goNamed(RouteNames.home),
            style: TextButton.styleFrom(
              minimumSize: _homeMinSize,
              foregroundColor: colors.textPrimary,
              textStyle: AppTextStyles.xsBold.copyWith(height: _textHeight),
            ),
            child: Text(AppLocaleKey.backToHome.tr()),
          ),
        ],
      ),
    );
  }
}
