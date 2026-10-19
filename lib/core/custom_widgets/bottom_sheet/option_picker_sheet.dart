import 'package:flutter/material.dart';

import '../../theme/app_sizes.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/extensions/theme_extensions.dart';

class OptionPickerSheet<T> extends StatelessWidget {
  const OptionPickerSheet({
    super.key,
    required this.title,
    required this.options,
    required this.labelOf,
    this.selected,
  });

  final String title;
  final List<T> options;
  final String Function(T option) labelOf;
  final T? selected;

  static const _handleSize = Size(36, 4);
  static const _radius = BorderRadius.vertical(top: Radius.circular(20));

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(color: colors.surface, borderRadius: _radius),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppSpacing.gapV10,
            Center(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.subtleBorder,
                  borderRadius: AppRadius.brCircle,
                ),
                child: SizedBox.fromSize(size: _handleSize),
              ),
            ),
            Padding(
              padding: AppPadding.v16h16,
              child: Text(title, style: AppTextStyles.mBold.copyWith(color: colors.textSecondary)),
            ),
            for (final option in options)
              ListTile(
                title: Text(
                  labelOf(option),
                  style: AppTextStyles.sMedium.copyWith(color: colors.textSecondary),
                ),
                trailing: option == selected
                    ? Icon(Icons.check_rounded, color: colors.primary)
                    : null,
                onTap: () => Navigator.pop(context, option),
              ),
            AppSpacing.gapV10,
          ],
        ),
      ),
    );
  }
}
