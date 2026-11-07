part of 'registration_status_cubit.dart';

class RegistrationStatusState extends Equatable {
  const RegistrationStatusState({
    required this.receipt,
    required this.reviews,
    this.filter = ReviewFilter.all,
  });

  final RegistrationReceipt receipt;
  final List<UnitReview> reviews;
  final ReviewFilter filter;

  List<UnitReview> get visibleReviews => [
    for (final review in reviews)
      if (filter.matches(review.status)) review,
  ];

  int get updateCount => reviews.where((review) => review.hasUpdate).length;

  OverallReviewStatus get overallStatus {
    if (reviews.any((review) => review.status == UnitReviewStatus.correctionRequired)) {
      return OverallReviewStatus.actionRequired;
    }
    if (reviews.isEmpty || reviews.any((review) => review.status == UnitReviewStatus.underReview)) {
      return OverallReviewStatus.underReview;
    }
    return OverallReviewStatus.reviewComplete;
  }

  RegistrationStatusState copyWith({ReviewFilter? filter}) {
    return RegistrationStatusState(
      receipt: receipt,
      reviews: reviews,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object?> get props => [receipt, reviews, filter];
}
