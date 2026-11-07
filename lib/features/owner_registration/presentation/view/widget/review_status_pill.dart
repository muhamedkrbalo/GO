import 'package:flutter/material.dart';

import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/custom_colors_extension.dart';
import '../../../data/model/unit_review.dart';

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

class ReviewStatusPill extends StatelessWidget {
  const ReviewStatusPill({
    super.key,
    required this.label,
    required this.background,
    required this.foreground,
  });

  final String label;
  final Color background;
  final Color foreground;

  static const _padding = EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 5);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: background, borderRadius: AppRadius.brCircle),
      child: Padding(
        padding: _padding,
        child: Text(
          label,
          style: AppTextStyles.xxxxxsMedium.copyWith(
            color: foreground,
            fontWeight: FontWeight.w800,
            height: _textHeight,
          ),
        ),
      ),
    );
  }
}
