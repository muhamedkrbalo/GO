import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/buttons/primary_arrow_button.dart';
import '../../../../../core/custom_widgets/registration_form/registration_sticky_footer.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';

class BrokerFormFooter extends StatelessWidget {
  const BrokerFormFooter({super.key, required this.isEnabled, required this.onContinue});

  final bool isEnabled;
  final VoidCallback? onContinue;

  @override
  Widget build(BuildContext context) {
    return RegistrationStickyFooter(
      saveAndExitAlignment: AlignmentDirectional.center,
      saveAndExitTextStyle: AppTextStyles.xxsBold,
      child: PrimaryArrowButton(
        text: AppLocaleKey.continue_.tr(),
        textStyle: AppTextStyles.xs13Bold,
        isEnabled: isEnabled,
        onPressed: onContinue,
      ),
    );
  }
}
