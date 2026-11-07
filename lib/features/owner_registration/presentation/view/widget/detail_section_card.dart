import 'package:flutter/material.dart';

import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class DetailSectionCard extends StatelessWidget {
  const DetailSectionCard({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  static const _padding = EdgeInsetsDirectional.all(15);
  static const _radius = BorderRadius.all(Radius.circular(13));
  static const _titleGap = SizedBox(height: 8);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: _radius,
        border: Border.all(color: colors.subtleBorder),
      ),
      child: Padding(
        padding: _padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: AppTextStyles.xxsBold.copyWith(color: colors.textPrimary, height: _textHeight),
            ),
            _titleGap,
            child,
          ],
        ),
      ),
    );
  }
}
