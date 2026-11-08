import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../data/model/broker_registration_receipt.dart';
import '../../controller/broker_registration_draft_cubit.dart';
import '../widget/broker_form_footer.dart';
import '../widget/broker_form_layout.dart';
import '../widget/broker_review_sections.dart';
import '../widget/broker_submit_readiness.dart';

class BrokerReviewScreen extends StatelessWidget {
  const BrokerReviewScreen({super.key});

  static const _step = 8;
  static const _readinessGap = SizedBox(height: 16);

  static void _submit(BuildContext context) {
    final receipt = BrokerRegistrationReceipt.issue(submittedAt: DateTime.now());
    context.goNamed(RouteNames.brokerSubmitted, extra: receipt);
    context.read<BrokerRegistrationDraftCubit>().clear();
  }

  @override
  Widget build(BuildContext context) {
    final isReady = context.select<BrokerRegistrationDraftCubit, bool>(
      (cubit) => cubit.state.isReadyToSubmit,
    );

    return BrokerFormLayout(
      step: _step,
      eyebrow: AppLocaleKey.reviewAndSubmit.tr(),
      title: AppLocaleKey.reviewYourInformation.tr(),
      subtitle: AppLocaleKey.reviewBrokerDetailsBeforeSubmitting.tr(),
      form: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const BrokerReviewSections(),
          _readinessGap,
          BrokerSubmitReadiness(isReady: isReady),
        ],
      ),
      footer: BrokerFormFooter(
        label: AppLocaleKey.submitBrokerRegistration.tr(),
        // isEnabled: isReady,
        isEnabled: true,
        onContinue: () => _submit(context),
      ),
    );
  }
}
