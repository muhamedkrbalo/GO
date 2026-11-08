import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/buttons/primary_arrow_button.dart';
import '../../../../../core/custom_widgets/registration_form/registration_notice.dart';
import '../../../../../core/custom_widgets/registration_form/registration_sticky_footer.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/broker_registration_receipt.dart';
import '../widget/broker_submission_details_card.dart';
import '../widget/broker_submission_hero.dart';

class BrokerSubmissionConfirmationScreen extends StatelessWidget {
  const BrokerSubmissionConfirmationScreen({super.key, required this.receipt});

  final BrokerRegistrationReceipt receipt;

  static const _contentPadding = EdgeInsetsDirectional.fromSTEB(22, 28, 22, 34);
  static const _detailsGap = SizedBox(height: 24);
  static const _noticeGap = SizedBox(height: 9);
  static const _noticeMaxWidth = 330.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.customColors.canvas,
      bottomNavigationBar: RegistrationStickyFooter(
        showSaveAndExit: false,
        child: PrimaryArrowButton(
          text: AppLocaleKey.viewRegistrationStatus.tr(),
          textStyle: AppTextStyles.xs13Bold,
          isEnabled: true,
          onPressed: null,
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: _contentPadding,
          children: [
            const BrokerSubmissionHero(),
            _detailsGap,
            BrokerSubmissionDetailsCard(receipt: receipt),
            _noticeGap,
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: _noticeMaxWidth),
                child: RegistrationNotice(
                  message: AppLocaleKey.brokerSubmissionDisclaimer.tr(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
