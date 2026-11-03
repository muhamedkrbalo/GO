import 'package:flutter/material.dart';

import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class RegistrationSectionCard extends StatelessWidget {
  const RegistrationSectionCard({
    super.key,
    required this.title,
    required this.children,
    this.hint,
  });

  final String title;
  final String? hint;
  final List<Widget> children;

  static const _padding = EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 20);
  static const _radius = BorderRadius.all(Radius.circular(14));
  static const _headerBottomPadding = 14.0;
  static const _gap = 18.0;
  static const _dividerOpacity = 0.5;
  static const _titleHeight = 1.5;
  static const _hintHeight = 1.3;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: _radius,
        border: Border.all(color: colors.subtleBorder),
        boxShadow: AppShadows.sectionCard,
      ),
      child: Padding(
        padding: _padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: colors.subtleBorder.withValues(alpha: _dividerOpacity)),
                ),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.only(bottom: _headerBottomPadding),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: AppTextStyles.xsBold.copyWith(
                          color: colors.textPrimary,
                          height: _titleHeight,
                        ),
                      ),
                    ),
                    if (hint != null)
                      Text(
                        hint!,
                        style: AppTextStyles.xxxxxsMedium.copyWith(
                          color: colors.hint,
                          height: _hintHeight,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            for (final child in children) ...[const SizedBox(height: _gap), child],
          ],
        ),
      ),
    );
  }
}
