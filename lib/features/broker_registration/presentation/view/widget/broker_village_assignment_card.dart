import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/status_pill/review_status_pill.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/custom_colors_extension.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/broker_village_assignment.dart';

extension BrokerVillageAssignmentStatusTone on BrokerVillageAssignmentStatus {
  (Color, Color) toneOf(CustomColors colors) => switch (this) {
    BrokerVillageAssignmentStatus.pendingEndorsement => (colors.goldSurface, colors.goldLink),
    BrokerVillageAssignmentStatus.active => (colors.successSurface, colors.success),
    BrokerVillageAssignmentStatus.rejected => (colors.errorSurface, colors.error),
    BrokerVillageAssignmentStatus.suspended ||
    BrokerVillageAssignmentStatus.expired => (colors.selectedSurface, colors.textMuted),
  };
}

class BrokerVillageAssignmentCard extends StatelessWidget {
  const BrokerVillageAssignmentCard({super.key, required this.assignment, this.onOpen});

  final BrokerVillageAssignment assignment;
  final VoidCallback? onOpen;

  static final _dateFormat = DateFormat('dd MMM yyyy');
  static const _padding = EdgeInsetsDirectional.fromSTEB(14, 14, 14, 4);
  static const _radius = BorderRadius.all(Radius.circular(12));
  static const _borderWidth = 1.5;
  static const _headerGap = SizedBox(width: 12);
  static const _nameToAreaGap = SizedBox(height: 3);
  static const _endorsementsGap = SizedBox(height: 10);
  static const _lastUpdatedGap = SizedBox(height: 5);
  static const _actionGap = SizedBox(height: 10);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final village = assignment.village;
    final (pillBackground, pillForeground) = assignment.status.toneOf(colors);
    final metaStyle = AppTextStyles.xxxxxsMedium.copyWith(
      fontWeight: FontWeight.w400,
      height: _textHeight,
    );

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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        village.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.xxxsBold.copyWith(
                          color: colors.textSecondary,
                          height: _textHeight,
                        ),
                      ),
                      _nameToAreaGap,
                      Text(
                        village.area,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: metaStyle.copyWith(color: colors.textMuted),
                      ),
                    ],
                  ),
                ),
                _headerGap,
                ReviewStatusPill(
                  label: assignment.status.labelKey.tr(),
                  background: pillBackground,
                  foreground: pillForeground,
                ),
              ],
            ),
            _endorsementsGap,
            Text(
              AppLocaleKey.endorsementsProgress.tr(
                args: ['${assignment.endorsementCount}', '${assignment.requiredEndorsements}'],
              ),
              style: metaStyle.copyWith(color: colors.formLabel),
            ),
            _lastUpdatedGap,
            Text(
              AppLocaleKey.lastUpdatedOn.tr(args: [_dateFormat.format(assignment.lastUpdated)]),
              style: metaStyle.copyWith(color: colors.textMuted),
            ),
            _actionGap,
            _OpenVillageButton(onPressed: onOpen),
          ],
        ),
      ),
    );
  }
}

class _OpenVillageButton extends StatelessWidget {
  const _OpenVillageButton({required this.onPressed});

  final VoidCallback? onPressed;

  static const _height = 38.0;
  static const _borderWidth = 1.5;
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: colors.subtleBorder, width: _borderWidth),
        ),
      ),
      child: Semantics(
        button: true,
        enabled: onPressed != null,
        child: InkWell(
          onTap: onPressed,
          child: SizedBox(
            height: _height,
            child: Center(
              child: Text(
                AppLocaleKey.openVillage.tr(),
                style: AppTextStyles.xxxxxsMedium.copyWith(
                  color: colors.oceanAccent,
                  fontWeight: FontWeight.w700,
                  height: _textHeight,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
