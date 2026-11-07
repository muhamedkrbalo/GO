import 'package:equatable/equatable.dart';

import '../../../../core/locale/app_locale_key.dart';
import 'owner_unit.dart';
import 'ownership_type.dart';
import 'submitted_unit.dart';

enum UnitReviewStatus {
  underReview(AppLocaleKey.underReview, AppLocaleKey.unitUnderReviewMessage),
  correctionRequired(AppLocaleKey.correctionRequired, AppLocaleKey.unitCorrectionMessage),
  approved(AppLocaleKey.approved, AppLocaleKey.unitApprovedMessage),
  rejected(AppLocaleKey.rejected, AppLocaleKey.unitRejectedMessage);

  const UnitReviewStatus(this.labelKey, this.messageKey);

  final String labelKey;
  final String messageKey;
}

enum ReviewFilter {
  all(AppLocaleKey.all),
  pending(AppLocaleKey.pending),
  actionRequired(AppLocaleKey.actionRequired),
  approved(AppLocaleKey.approved),
  rejected(AppLocaleKey.rejected);

  const ReviewFilter(this.labelKey);

  final String labelKey;

  bool matches(UnitReviewStatus status) => switch (this) {
    ReviewFilter.all => true,
    ReviewFilter.pending => status == UnitReviewStatus.underReview,
    ReviewFilter.actionRequired => status == UnitReviewStatus.correctionRequired,
    ReviewFilter.approved => status == UnitReviewStatus.approved,
    ReviewFilter.rejected => status == UnitReviewStatus.rejected,
  };
}

enum OverallReviewStatus {
  actionRequired(AppLocaleKey.actionRequired),
  underReview(AppLocaleKey.underReview),
  reviewComplete(AppLocaleKey.reviewComplete);

  const OverallReviewStatus(this.labelKey);

  final String labelKey;
}

class ReviewTimelineEvent extends Equatable {
  const ReviewTimelineEvent({required this.titleKey, required this.date, required this.isComplete});

  final String titleKey;
  final DateTime date;
  final bool isComplete;

  @override
  List<Object?> get props => [titleKey, date, isComplete];
}

class UnitReview extends Equatable {
  const UnitReview({
    required this.submission,
    required this.status,
    required this.submittedAt,
    this.hasUpdate = false,
    this.timeline = const [],
  });

  final SubmittedUnit submission;
  final UnitReviewStatus status;
  final DateTime submittedAt;
  final bool hasUpdate;
  final List<ReviewTimelineEvent> timeline;

  OwnerUnit get unit => submission.unit;

  OwnershipType? get ownershipType => submission.ownershipType;

  @override
  List<Object?> get props => [submission, status, submittedAt, hasUpdate, timeline];
}
