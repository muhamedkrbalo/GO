import 'package:flutter/material.dart';

import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class PackageDetailsSectionCard extends StatelessWidget {
  const PackageDetailsSectionCard({
    super.key,
    required this.child,
    this.title,
    this.isTitleBold = false,
    this.titleGap = AppSpacing.m10,
    this.padding = const EdgeInsetsDirectional.all(14),
    this.borderRadius = AppRadius.brSm,
  });

  final Widget child;
  final String? title;
  final bool isTitleBold;
  final double titleGap;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;

  static const _borderWidth = 1.6;
  static const _titleHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final title = this.title;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: borderRadius,
        border: Border.all(color: colors.subtleBorder, width: _borderWidth),
      ),
      child: Padding(
        padding: padding,
        child: title == null
            ? child
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    style: (isTitleBold ? AppTextStyles.xxsBold : AppTextStyles.xxsRegular)
                        .copyWith(color: colors.textPrimary, height: _titleHeight),
                  ),
                  SizedBox(height: titleGap),
                  child,
                ],
              ),
      ),
    );
  }
}
