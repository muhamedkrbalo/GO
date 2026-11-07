import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/registration_receipt.dart';
import '../../../data/model/unit_review.dart';
import 'review_status_pill.dart';

class OverallStatusCard extends StatelessWidget {
  const OverallStatusCard({super.key, required this.receipt, required this.status});

  final RegistrationReceipt receipt;
  final OverallReviewStatus status;

  static final _dateFormat = DateFormat('dd MMM yyyy');
  static const _radius = BorderRadius.all(Radius.circular(14));
  static const _headerMinHeight = 58.0;
  static const _headerPadding = EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 12);
  static const _referenceFlex = 4;
  static const _dateFlex = 3;
  static const _unitsFlex = 2;
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final (background, foreground) = status.toneOf(colors);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: _radius,
        border: Border.all(color: colors.subtleBorder),
        boxShadow: AppShadows.roleCard,
      ),
      child: Column(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: colors.subtleBorder)),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: _headerMinHeight),
              child: Padding(
                padding: _headerPadding,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        AppLocaleKey.overallRegistrationStatus.tr(),
                        style: AppTextStyles.xxxxsBold.copyWith(
                          color: colors.textMuted,
                          fontWeight: FontWeight.w600,
                          height: _textHeight,
                        ),
                      ),
                    ),
                    AppSpacing.gapH8,
                    ReviewStatusPill(
                      label: status.labelKey.tr(),
                      background: background,
                      foreground: foreground,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: _referenceFlex,
                child: _OverviewCell(
                  label: AppLocaleKey.referenceNumber.tr(),
                  value: receipt.referenceNumber,
                  isLtr: true,
                  hasDivider: true,
                ),
              ),
              Expanded(
                flex: _dateFlex,
                child: _OverviewCell(
                  label: AppLocaleKey.submissionDate.tr(),
                  value: _dateFormat.format(receipt.submittedAt),
                  hasDivider: true,
                ),
              ),
              Expanded(
                flex: _unitsFlex,
                child: _OverviewCell(
                  label: AppLocaleKey.totalUnits.tr(),
                  value: '${receipt.unitCount}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OverviewCell extends StatelessWidget {
  const _OverviewCell({
    required this.label,
    required this.value,
    this.isLtr = false,
    this.hasDivider = false,
  });

  final String label;
  final String value;
  final bool isLtr;
  final bool hasDivider;

  static const _minHeight = 62.0;
  static const _padding = EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 14);
  static const _gap = SizedBox(height: 4);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: hasDivider ? BorderDirectional(end: BorderSide(color: colors.subtleBorder)) : null,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: _minHeight),
        child: Padding(
          padding: _padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.xxxxxsMedium.copyWith(
                  color: colors.hint,
                  fontWeight: FontWeight.w600,
                  height: _textHeight,
                ),
              ),
              _gap,
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textDirection: isLtr ? ui.TextDirection.ltr : null,
                style: AppTextStyles.xxxxsBold.copyWith(
                  color: colors.textPrimary,
                  height: _textHeight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
