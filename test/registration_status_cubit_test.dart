import 'package:flutter_hr_erb/features/owner_registration/data/model/ownership_type.dart';
import 'package:flutter_hr_erb/features/owner_registration/data/model/registration_receipt.dart';
import 'package:flutter_hr_erb/features/owner_registration/data/model/sample_unit_reviews.dart';
import 'package:flutter_hr_erb/features/owner_registration/data/model/sample_units.dart';
import 'package:flutter_hr_erb/features/owner_registration/data/model/unit_review.dart';
import 'package:flutter_hr_erb/features/owner_registration/presentation/controller/registration_status_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final submittedAt = DateTime(2026, 11, 3);
  final units = [sampleUnits[0], sampleUnits[3], sampleUnits[5], sampleUnits[7]];
  final receipt = RegistrationReceipt.issue(
    submittedAt: submittedAt,
    units: units,
    ownershipTypes: {units[0].id: OwnershipType.sole},
  );
  late RegistrationStatusCubit cubit;

  UnitReview review(int index, UnitReviewStatus status) =>
      UnitReview(unit: units[index], status: status, submittedAt: submittedAt);

  setUp(
    () => cubit = RegistrationStatusCubit(receipt: receipt, reviews: prototypeUnitReviews(receipt)),
  );

  tearDown(() => cubit.close());

  test('prototype reviews cover every submitted unit with its ownership type', () {
    final reviews = cubit.state.reviews;

    expect(reviews.map((review) => review.unit), units);
    expect(reviews.first.ownershipType, OwnershipType.sole);
    expect(reviews[1].ownershipType, isNull);
    expect(reviews.map((review) => review.status), UnitReviewStatus.values);
    expect(cubit.state.updateCount, 2);
  });

  test('filters narrow the visible reviews and All shows everything again', () {
    cubit.selectFilter(ReviewFilter.actionRequired);
    expect(cubit.state.visibleReviews.single.status, UnitReviewStatus.correctionRequired);

    cubit.selectFilter(ReviewFilter.pending);
    expect(cubit.state.visibleReviews.single.status, UnitReviewStatus.underReview);

    cubit.selectFilter(ReviewFilter.all);
    expect(cubit.state.visibleReviews, cubit.state.reviews);
  });

  test('selecting the current filter does not emit', () async {
    final states = <RegistrationStatusState>[];
    final subscription = cubit.stream.listen(states.add);

    cubit.selectFilter(ReviewFilter.all);
    await Future<void>.delayed(Duration.zero);
    await subscription.cancel();

    expect(states, isEmpty);
  });

  test('overall status prefers action required, then under review, then complete', () {
    RegistrationStatusCubit withReviews(List<UnitReview> reviews) {
      final status = RegistrationStatusCubit(receipt: receipt, reviews: reviews);
      addTearDown(status.close);
      return status;
    }

    expect(cubit.state.overallStatus, OverallReviewStatus.actionRequired);
    expect(
      withReviews([
        review(0, UnitReviewStatus.underReview),
        review(1, UnitReviewStatus.approved),
      ]).state.overallStatus,
      OverallReviewStatus.underReview,
    );
    expect(
      withReviews([
        review(0, UnitReviewStatus.approved),
        review(1, UnitReviewStatus.rejected),
      ]).state.overallStatus,
      OverallReviewStatus.reviewComplete,
    );
  });
}
