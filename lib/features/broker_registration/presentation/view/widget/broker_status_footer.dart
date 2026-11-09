import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/buttons/primary_arrow_button.dart';
import '../../../../../core/custom_widgets/registration_form/registration_sticky_footer.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';

class BrokerStatusFooter extends StatelessWidget {
  const BrokerStatusFooter({super.key, required this.onContinue});

  final VoidCallback? onContinue;

  @override
  Widget build(BuildContext context) {
    return RegistrationStickyFooter(
      showSaveAndExit: false,
      child: PrimaryArrowButton(
        text: AppLocaleKey.continueToVillageSelection.tr(),
        textStyle: AppTextStyles.xs13Bold,
        isEnabled: true,
        onPressed: onContinue,
      ),
    );
  }
}
