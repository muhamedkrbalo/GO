import 'package:flutter/material.dart';

import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

enum StatusPillTone { success, warning, neutral }

class StatusPill extends StatelessWidget {
  const StatusPill({super.key, required this.label, required this.tone});

  final String label;
  final StatusPillTone tone;

  static const _padding = EdgeInsets.symmetric(horizontal: 6.4, vertical: 3.5);

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final (background, foreground) = switch (tone) {
      StatusPillTone.success => (colors.primaryLight, colors.accentText),
      StatusPillTone.warning => (colors.warningSurface, colors.warning),
      StatusPillTone.neutral => (colors.subtleBorder, colors.textMuted),
    };

    return DecoratedBox(
      decoration: BoxDecoration(color: background, borderRadius: AppRadius.brCircle),
      child: Padding(
        padding: _padding,
        child: Text(label, style: AppTextStyles.xxxsBold.copyWith(color: foreground, height: 1.3)),
      ),
    );
  }
}
