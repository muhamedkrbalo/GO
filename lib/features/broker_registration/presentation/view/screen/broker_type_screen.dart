import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/registration_step_header/registration_step_header.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/broker_type.dart';
import '../widget/broker_type_actions.dart';
import '../widget/broker_type_intro.dart';
import '../widget/broker_type_option.dart';

class BrokerTypeScreen extends StatelessWidget {
  const BrokerTypeScreen({super.key});

  static const _step = 1;
  static const _totalSteps = 8;
  static const _contentPadding = EdgeInsetsDirectional.fromSTEB(24, 34, 24, 38);
  static const _introToCardsGap = 30.0;
  static const _cardsGap = 14.0;
  static const _cardsToActionsGap = 28.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.customColors.canvas,
      body: Column(
        children: [
          RegistrationStepHeader(
            title: AppLocaleKey.brokerRegistration.tr(),
            stepLabel: AppLocaleKey.stepOfTotal.tr(args: ['$_step', '$_totalSteps']),
            progress: _step / _totalSteps,
          ),
          Expanded(
            child: SafeArea(
              top: false,
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: _contentPadding,
                    sliver: SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BrokerTypeIntro(),
                          const SizedBox(height: _introToCardsGap),
                          for (final type in BrokerType.values) ...[
                            if (type.index > 0) const SizedBox(height: _cardsGap),
                            BrokerTypeOption(type: type),
                          ],
                          const Spacer(),
                          const SizedBox(height: _cardsToActionsGap),
                          const BrokerTypeActions(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
