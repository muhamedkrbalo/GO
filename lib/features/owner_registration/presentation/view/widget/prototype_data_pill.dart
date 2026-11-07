import 'package:flutter/material.dart';

import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class PrototypeDataPill extends StatelessWidget {
  const PrototypeDataPill({super.key, required this.label});

  final String label;

  static const _padding = EdgeInsetsDirectional.symmetric(horizontal: 7, vertical: 4);
  static const _letterSpacing = 0.42;
  static const _textHeight = 1.3;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(color: colors.goldSurface, borderRadius: AppRadius.brCircle),
      child: Padding(
        padding: _padding,
        child: Text(
          label.toUpperCase(),
          style: AppTextStyles.xxxxxsMedium.copyWith(
            color: colors.stepLabel,
            fontWeight: FontWeight.w700,
            letterSpacing: _letterSpacing,
            height: _textHeight,
          ),
        ),
      ),
    );
  }
}
