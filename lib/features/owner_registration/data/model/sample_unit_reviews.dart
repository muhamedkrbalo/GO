import '../../../../core/locale/app_locale_key.dart';
import 'registration_receipt.dart';
import 'unit_review.dart';

const _prototypeStatuses = [
  UnitReviewStatus.underReview,
  UnitReviewStatus.correctionRequired,
  UnitReviewStatus.approved,
  UnitReviewStatus.rejected,
];

const _reviewStartDelay = Duration(days: 1);
const _statusUpdateDelay = Duration(days: 2);

List<ReviewTimelineEvent> _prototypeTimeline(DateTime submittedAt, UnitReviewStatus status) {
  return [
    ReviewTimelineEvent(
      titleKey: AppLocaleKey.registrationSubmittedEvent,
      date: submittedAt,
      isComplete: true,
    ),
    ReviewTimelineEvent(
      titleKey: AppLocaleKey.reviewStarted,
      date: submittedAt.add(_reviewStartDelay),
      isComplete: true,
    ),
    ReviewTimelineEvent(
      titleKey: status.labelKey,
      date: submittedAt.add(_statusUpdateDelay),
      isComplete: status != UnitReviewStatus.underReview,
    ),
  ];
}

UnitReview _prototypeReview(RegistrationReceipt receipt, int index) {
  final status = _prototypeStatuses[index % _prototypeStatuses.length];
  return UnitReview(
    submission: receipt.units[index],
    status: status,
    submittedAt: receipt.submittedAt,
    hasUpdate: index < 2,
    timeline: _prototypeTimeline(receipt.submittedAt, status),
  );
}

List<UnitReview> prototypeUnitReviews(RegistrationReceipt receipt) {
  return [
    for (var index = 0; index < receipt.units.length; index++) _prototypeReview(receipt, index),
  ];
}
