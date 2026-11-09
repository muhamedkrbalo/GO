import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/registration_form/registration_intro.dart';
import '../../../../../core/custom_widgets/registration_step_header/registration_step_header.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/broker_village_assignment.dart';
import '../widget/broker_endorsement_progress_bar.dart';
import '../widget/broker_endorsement_summary_card.dart';

class BrokerVillageEndorsementScreen extends StatelessWidget {
  const BrokerVillageEndorsementScreen({super.key, required this.assignment});

  final BrokerVillageAssignment assignment;

  static const _contentPadding = EdgeInsetsDirectional.fromSTEB(22, 28, 22, 34);
  static const _introToCardGap = SizedBox(height: 22);
  static const _cardToProgressGap = SizedBox(height: 14);

  @override
  Widget build(BuildContext context) {
    final title = AppLocaleKey.villageEndorsement.tr();

    return Scaffold(
      backgroundColor: context.customColors.canvas,
      body: Column(
        children: [
          RegistrationStepHeader(title: title),
          Expanded(
            child: SafeArea(
              top: false,
              child: ListView(
                padding: _contentPadding,
                children: [
                  RegistrationIntro(
                    eyebrow: assignment.village.area,
                    title: title,
                    subtitle: AppLocaleKey.endorsementsProvidedByOwners.tr(),
                  ),
                  _introToCardGap,
                  BrokerEndorsementSummaryCard(assignment: assignment),
                  _cardToProgressGap,
                  BrokerEndorsementProgressBar(
                    received: assignment.endorsementCount,
                    required: assignment.requiredEndorsements,
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
