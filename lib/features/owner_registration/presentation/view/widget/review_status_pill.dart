import 'package:flutter/material.dart';

import '../../../../../core/theme/extensions/custom_colors_extension.dart';
import '../../../data/model/unit_review.dart';

export '../../../../../core/custom_widgets/status_pill/review_status_pill.dart';

extension UnitReviewStatusTone on UnitReviewStatus {
  (Color, Color) toneOf(CustomColors colors) => switch (this) {
    UnitReviewStatus.underReview => (colors.goldSurface, colors.goldLink),
    UnitReviewStatus.correctionRequired ||
    UnitReviewStatus.rejected => (colors.errorSurface, colors.error),
    UnitReviewStatus.approved => (colors.successSurface, colors.success),
  };
}

extension OverallReviewStatusTone on OverallReviewStatus {
  (Color, Color) toneOf(CustomColors colors) => switch (this) {
    OverallReviewStatus.actionRequired => (colors.errorSurface, colors.error),
    OverallReviewStatus.underReview => (colors.goldSurface, colors.goldLink),
    OverallReviewStatus.reviewComplete => (colors.successSurface, colors.success),
  };
}
