import 'package:flutter/material.dart';

import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class OwnerPackageFeatureList extends StatelessWidget {
  const OwnerPackageFeatureList({
    super.key,
    required this.features,
    this.isIncluded = true,
    this.spacing = 6,
  });

  final List<String> features;
  final bool isIncluded;
  final double spacing;

  static const _iconSize = 9.0;
  static const _iconGap = SizedBox(width: 4);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final textStyle = AppTextStyles.xxxxxsMedium.copyWith(
      color: colors.linkMuted,
      fontWeight: FontWeight.w400,
      height: _textHeight,
    );
    final marker = Icon(
      isIncluded ? Icons.check_rounded : Icons.remove_rounded,
      size: _iconSize,
      color: colors.linkMuted,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spacing,
      children: [
        for (final feature in features)
          Row(
            children: [
              marker,
              _iconGap,
              Expanded(child: Text(feature, style: textStyle)),
            ],
          ),
      ],
    );
  }
}
