import 'package:flutter/material.dart';

import '../../theme/app_sizes.dart';
import '../../theme/app_text_styles.dart';

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
