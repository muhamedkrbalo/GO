import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/registration_form/review_info_rows.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/broker_village_assignment.dart';

class BrokerEndorsementSummaryCard extends StatelessWidget {
  const BrokerEndorsementSummaryCard({super.key, required this.assignment});

  final BrokerVillageAssignment assignment;

  static const _padding = EdgeInsetsDirectional.fromSTEB(16, 16, 16, 6);
  static const _radius = BorderRadius.all(Radius.circular(13));
  static const _borderWidth = 1.5;
  static const _titleGap = SizedBox(height: 10);
  static const _titleHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final received = '${assignment.endorsementCount}';
    final required = '${assignment.requiredEndorsements}';

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: _radius,
        border: Border.all(color: colors.subtleBorder, width: _borderWidth),
      ),
      child: Padding(
        padding: _padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              assignment.village.name,
              style: AppTextStyles.xs13Regular.copyWith(
                color: colors.textPrimary,
                height: _titleHeight,
              ),
            ),
            _titleGap,
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: colors.selectedSurface)),
              ),
              child: ReviewInfoRows(
                items: [
                  ReviewInfoItem(label: AppLocaleKey.requiredEndorsements.tr(), rawValue: required),
                  ReviewInfoItem(label: AppLocaleKey.receivedEndorsements.tr(), rawValue: received),
                  ReviewInfoItem(
                    label: AppLocaleKey.progress.tr(),
                    rawValue: AppLocaleKey.countOfTotal.tr(args: [received, required]),
                  ),
                  ReviewInfoItem(
                    label: AppLocaleKey.endorsementStatus.tr(),
                    rawValue: assignment.endorsementStatusKey.tr(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
