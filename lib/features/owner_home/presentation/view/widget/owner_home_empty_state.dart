import 'package:flutter/material.dart';

import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class OwnerHomeEmptyState extends StatelessWidget {
  const OwnerHomeEmptyState({super.key, required this.title, required this.message});

  final String title;
  final String message;

  static const _padding = EdgeInsetsDirectional.all(14);
  static const _radius = BorderRadius.all(Radius.circular(10));
  static const _messageGap = SizedBox(height: 4);
  static const _titleHeight = 1.5;
  static const _messageHeight = 1.45;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(color: colors.canvas, borderRadius: _radius),
      child: Padding(
        padding: _padding,
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.xxxxsBold.copyWith(
                color: colors.formLabel,
                height: _titleHeight,
              ),
            ),
            _messageGap,
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.xxxxxsMedium.copyWith(
                color: colors.textMuted,
                fontWeight: FontWeight.w400,
                height: _messageHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
