import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/owner_unit.dart';

class UnitStatusBadge extends StatelessWidget {
  const UnitStatusBadge({super.key, required this.status});

  final UnitStatus status;

  static const _padding = EdgeInsets.symmetric(horizontal: 6.7, vertical: 3.5);

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final (background, foreground) = switch (status) {
      UnitStatus.eligible => (colors.primaryLight, colors.accentText),
      UnitStatus.alreadyOwned => (colors.subtleBorder, colors.textMuted),
      UnitStatus.notEligible || UnitStatus.inactive => (colors.warningSurface, colors.warning),
    };

    return DecoratedBox(
      decoration: BoxDecoration(color: background, borderRadius: AppRadius.brCircle),
      child: Padding(
        padding: _padding,
        child: Text(
          status.labelKey.tr(),
          style: AppTextStyles.xxxsBold.copyWith(color: foreground, height: 1.3),
        ),
      ),
    );
  }
}
