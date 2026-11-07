import 'registration_receipt.dart';
import 'unit_review.dart';

const _prototypeStatuses = [
  UnitReviewStatus.underReview,
  UnitReviewStatus.correctionRequired,
  UnitReviewStatus.approved,
  UnitReviewStatus.rejected,
];

List<UnitReview> prototypeUnitReviews(RegistrationReceipt receipt) {
  return [
    for (var index = 0; index < receipt.units.length; index++)
      UnitReview(
        unit: receipt.units[index],
        status: _prototypeStatuses[index % _prototypeStatuses.length],
        submittedAt: receipt.submittedAt,
        ownershipType: receipt.ownershipTypes[receipt.units[index].id],
        hasUpdate: index < 2,
      ),
  ];
}
