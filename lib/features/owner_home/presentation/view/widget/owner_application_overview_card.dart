import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/status_pill/review_status_pill.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/owner_home_overview.dart';
import 'owner_home_card_link.dart';
import 'owner_home_section_card.dart';
import 'owner_home_section_heading.dart';

class OwnerApplicationOverviewCard extends StatelessWidget {
  const OwnerApplicationOverviewCard({super.key, required this.overview});

  final OwnerHomeOverview overview;

  static final _dateFormat = DateFormat('dd MMM yyyy');
  static const _gridGap = SizedBox(height: 13);
  static const _gridRadius = BorderRadius.all(Radius.circular(10));
  static const _borderWidth = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final submittedAt = overview.submittedAt;
    final divider = BorderSide(color: colors.selectedSurface, width: _borderWidth);
    final (pillBackground, pillForeground) = overview.isSubmitted
        ? (colors.iconTileSurface, colors.oceanAccent)
        : (colors.goldSurface, colors.goldLink);

    return OwnerHomeSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OwnerHomeSectionHeading(
            eyebrow: AppLocaleKey.applicationOverview.tr(),
            title: AppLocaleKey.ownershipApplication.tr(),
            trailing: ReviewStatusPill(
              label: (overview.isSubmitted ? AppLocaleKey.pendingReview : AppLocaleKey.notSubmitted)
                  .tr(),
              background: pillBackground,
              foreground: pillForeground,
            ),
          ),
          _gridGap,
          DecoratedBox(
            decoration: BoxDecoration(
              color: colors.canvas,
              borderRadius: _gridRadius,
              border: Border.all(color: colors.selectedSurface, width: _borderWidth),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _OverviewCell(
                        label: AppLocaleKey.reference.tr(),
                        value: overview.referenceNumber ?? AppLocaleKey.notSubmitted.tr(),
                        valueDirection: overview.isSubmitted ? ui.TextDirection.ltr : null,
                        border: BorderDirectional(bottom: divider, end: divider),
                      ),
                    ),
                    Expanded(
                      child: _OverviewCell(
                        label: AppLocaleKey.submitted.tr(),
                        value: submittedAt == null
                            ? AppLocaleKey.notAvailable.tr()
                            : _dateFormat.format(submittedAt),
                        border: BorderDirectional(bottom: divider),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _OverviewCell(
                        label: AppLocaleKey.totalUnits.tr(),
                        value: '${overview.totalUnits}',
                        border: BorderDirectional(end: divider),
                      ),
                    ),
                    Expanded(
                      child: _OverviewCell(
                        label: AppLocaleKey.actionRequired.tr(),
                        value: '${overview.actionRequired}',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          OwnerHomeCardLink(label: AppLocaleKey.viewApplicationDetails.tr()),
        ],
      ),
    );
  }
}

class _OverviewCell extends StatelessWidget {
  const _OverviewCell({required this.label, required this.value, this.border, this.valueDirection});

  final String label;
  final String value;
  final BorderDirectional? border;
  final ui.TextDirection? valueDirection;

  static const _padding = EdgeInsetsDirectional.all(10);
  static const _valueGap = SizedBox(height: 4);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(border: border),
      child: Padding(
        padding: _padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTextStyles.xxxxxsMedium.copyWith(
                color: colors.textMuted,
                fontWeight: FontWeight.w400,
                height: _textHeight,
              ),
            ),
            _valueGap,
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textDirection: valueDirection,
              style: AppTextStyles.xxxxsBold.copyWith(
                color: colors.textSecondary,
                height: _textHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
