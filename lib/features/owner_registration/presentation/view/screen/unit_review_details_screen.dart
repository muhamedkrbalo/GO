import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/registration_form/review_info_rows.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/unit_review.dart';
import '../widget/centered_title_header.dart';
import '../widget/detail_section_card.dart';
import '../widget/review_status_pill.dart';
import '../widget/review_timeline.dart';
import '../widget/submitted_documents_list.dart';

class UnitReviewDetailsScreen extends StatelessWidget {
  const UnitReviewDetailsScreen({super.key, required this.review});

  final UnitReview review;

  static final _dateFormat = DateFormat('dd/MM/yyyy');
  static const _contentPadding = EdgeInsetsDirectional.fromSTEB(20, 24, 20, 36);
  static const _sectionGap = SizedBox(height: 18);

  @override
  Widget build(BuildContext context) {
    final submission = review.submission;
    final unit = submission.unit;
    final ownershipDate = submission.ownershipDate;

    return Scaffold(
      backgroundColor: context.customColors.canvas,
      body: Column(
        children: [
          CenteredTitleHeader(title: AppLocaleKey.unitReviewDetails.tr()),
          Expanded(
            child: ListView(
              padding: _contentPadding,
              children: [
                _UnitReviewHeading(review: review),
                _sectionGap,
                DetailSectionCard(
                  title: AppLocaleKey.unitInformation.tr(),
                  child: ReviewInfoRows(
                    items: [
                      ReviewInfoItem(label: AppLocaleKey.unitNumber.tr(), rawValue: unit.name),
                      ReviewInfoItem(label: AppLocaleKey.building.tr(), rawValue: unit.building),
                      ReviewInfoItem(label: AppLocaleKey.village.tr(), rawValue: unit.village),
                      ReviewInfoItem(
                        label: AppLocaleKey.unitType.tr(),
                        rawValue: unit.type.labelKey.tr(),
                      ),
                    ],
                  ),
                ),
                _sectionGap,
                DetailSectionCard(
                  title: AppLocaleKey.submittedOwnershipDetails.tr(),
                  child: ReviewInfoRows(
                    items: [
                      ReviewInfoItem(
                        label: AppLocaleKey.ownershipType.tr(),
                        rawValue: submission.ownershipType?.labelKey.tr(),
                      ),
                      ReviewInfoItem(
                        label: AppLocaleKey.ownershipDate.tr(),
                        rawValue: ownershipDate == null ? null : _dateFormat.format(ownershipDate),
                      ),
                      ReviewInfoItem(
                        label: AppLocaleKey.documentNumber.tr(),
                        rawValue: submission.documentNumber,
                        isLtr: true,
                      ),
                    ],
                  ),
                ),
                _sectionGap,
                DetailSectionCard(
                  title: AppLocaleKey.submittedDocuments.tr(),
                  child: SubmittedDocumentsList(documents: submission.documents),
                ),
                _sectionGap,
                DetailSectionCard(
                  title: AppLocaleKey.reviewTimeline.tr(),
                  child: ReviewTimeline(events: review.timeline),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UnitReviewHeading extends StatelessWidget {
  const _UnitReviewHeading({required this.review});

  final UnitReview review;

  static const _lineGap = SizedBox(height: 4);
  static const _eyebrowLetterSpacing = 0.8;
  static const _eyebrowHeight = 1.5;
  static const _titleHeight = 1.4;
  static const _locationHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final unit = review.unit;
    final building = unit.building;
    final (background, foreground) = review.status.toneOf(colors);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocaleKey.unitReview.tr().toUpperCase(),
                style: AppTextStyles.xxxxxsMedium.copyWith(
                  color: colors.oceanAccent,
                  fontWeight: FontWeight.w700,
                  letterSpacing: _eyebrowLetterSpacing,
                  height: _eyebrowHeight,
                ),
              ),
              _lineGap,
              Text(
                unit.name,
                style: AppTextStyles.xxlSemiBold.copyWith(
                  color: colors.textSecondary,
                  height: _titleHeight,
                ),
              ),
              _lineGap,
              Text(
                building == null ? unit.village : '$building · ${unit.village}',
                style: AppTextStyles.xxxxsRegular.copyWith(
                  color: colors.textMuted,
                  height: _locationHeight,
                ),
              ),
            ],
          ),
        ),
        AppSpacing.gapH8,
        ReviewStatusPill(
          label: review.status.labelKey.tr(),
          background: background,
          foreground: foreground,
        ),
      ],
    );
  }
}
