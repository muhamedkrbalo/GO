import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/unit_review.dart';
import 'review_status_pill.dart';

class UnitReviewCard extends StatelessWidget {
  const UnitReviewCard({super.key, required this.review, this.onViewDetails});

  final UnitReview review;
  final VoidCallback? onViewDetails;

  static final _dateFormat = DateFormat('dd MMM yyyy');
  static const _radius = BorderRadius.all(Radius.circular(13));
  static const _headerPadding = EdgeInsetsDirectional.fromSTEB(14, 14, 14, 0);
  static const _bodyPadding = EdgeInsetsDirectional.symmetric(horizontal: 14);
  static const _locationGap = SizedBox(height: 4);
  static const _detailsGap = SizedBox(height: 12);
  static const _detailsPadding = EdgeInsetsDirectional.symmetric(vertical: 10);
  static const _messageGap = SizedBox(height: 12);
  static const _actionMinHeight = 44.0;
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final unit = review.unit;
    final building = unit.building;
    final (background, foreground) = review.status.toneOf(colors);

    return DecoratedBox(
      decoration: const BoxDecoration(borderRadius: _radius, boxShadow: AppShadows.sectionCard),
      child: Material(
        color: colors.surface,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: _radius,
          side: BorderSide(color: colors.subtleBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: _headerPadding,
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      unit.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.xsBold.copyWith(
                        color: colors.textSecondary,
                        height: _textHeight,
                      ),
                    ),
                  ),
                  if (review.hasUpdate) ...[const SizedBox(width: 7), const _UpdateBadge()],
                  const Spacer(),
                  ReviewStatusPill(
                    label: review.status.labelKey.tr(),
                    background: background,
                    foreground: foreground,
                  ),
                ],
              ),
            ),
            Padding(
              padding: _bodyPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _locationGap,
                  Text(
                    building == null ? unit.village : '$building · ${unit.village}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.xxxxxsMedium.copyWith(
                      color: colors.textMuted,
                      fontWeight: FontWeight.w400,
                      height: _textHeight,
                    ),
                  ),
                  _detailsGap,
                  DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: colors.selectedSurface)),
                    ),
                    child: Padding(
                      padding: _detailsPadding,
                      child: Row(
                        children: [
                          Expanded(
                            child: _ReviewDetail(
                              label: AppLocaleKey.ownershipType.tr(),
                              value:
                                  review.ownershipType?.labelKey.tr() ??
                                  AppLocaleKey.notProvided.tr(),
                            ),
                          ),
                          AppSpacing.gapH10,
                          Expanded(
                            child: _ReviewDetail(
                              label: AppLocaleKey.submitted.tr(),
                              value: _dateFormat.format(review.submittedAt),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _ReviewMessage(message: review.status.messageKey.tr()),
                  _messageGap,
                ],
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: colors.subtleBorder)),
              ),
              child: Semantics(
                button: true,
                child: InkWell(
                  onTap: onViewDetails,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: _actionMinHeight),
                    child: Center(
                      child: Text(
                        AppLocaleKey.viewDetails.tr(),
                        style: AppTextStyles.xxxxsBold.copyWith(
                          color: colors.oceanAccent,
                          height: _textHeight,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UpdateBadge extends StatelessWidget {
  const _UpdateBadge();

  static const _padding = EdgeInsetsDirectional.symmetric(horizontal: 5, vertical: 3);
  static const _letterSpacing = 0.24;
  static const _textHeight = 1.3;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(color: colors.error, borderRadius: AppRadius.brCircle),
      child: Padding(
        padding: _padding,
        child: Text(
          AppLocaleKey.update.tr().toUpperCase(),
          style: AppTextStyles.xxxxxsMedium.copyWith(
            color: colors.onPrimary,
            fontWeight: FontWeight.w800,
            letterSpacing: _letterSpacing,
            height: _textHeight,
          ),
        ),
      ),
    );
  }
}

class _ReviewDetail extends StatelessWidget {
  const _ReviewDetail({required this.label, required this.value});

  final String label;
  final String value;

  static const _gap = SizedBox(height: 3);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.xxxxxsMedium.copyWith(
            color: colors.hint,
            fontWeight: FontWeight.w400,
            height: _textHeight,
          ),
        ),
        _gap,
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.xxxxxsMedium.copyWith(
            color: colors.formLabel,
            fontWeight: FontWeight.w700,
            height: _textHeight,
          ),
        ),
      ],
    );
  }
}

class _ReviewMessage extends StatelessWidget {
  const _ReviewMessage({required this.message});

  final String message;

  static const _padding = EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 9);
  static const _radius = BorderRadius.all(Radius.circular(8));
  static const _dotPadding = EdgeInsetsDirectional.only(top: 3);
  static const _dotSize = 7.0;
  static const _textHeight = 1.4;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(color: colors.canvas, borderRadius: _radius),
      child: Padding(
        padding: _padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: _dotPadding,
              child: DecoratedBox(
                decoration: BoxDecoration(color: colors.accentBar, shape: BoxShape.circle),
                child: const SizedBox.square(dimension: _dotSize),
              ),
            ),
            AppSpacing.gapH8,
            Expanded(
              child: Text(
                message,
                style: AppTextStyles.xxxxxsMedium.copyWith(
                  color: colors.textMuted,
                  fontWeight: FontWeight.w400,
                  height: _textHeight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
