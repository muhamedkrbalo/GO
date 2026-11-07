import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/owner_unit.dart';

class UnitStatusBadge extends StatelessWidget {
  const UnitStatusBadge({super.key, required this.status});

  final UnitStatus status;

  static const _padding = EdgeInsetsDirectional.symmetric(horizontal: 7, vertical: 4);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final (background, foreground) = switch (status) {
      UnitStatus.eligible => (colors.successSurface, colors.success),
      UnitStatus.alreadyOwned || UnitStatus.notEligible => (colors.errorSurface, colors.error),
      UnitStatus.inactive => (colors.primaryLight, colors.textMuted),
    };

    return DecoratedBox(
      decoration: BoxDecoration(color: background, borderRadius: AppRadius.brCircle),
      child: Padding(
        padding: _padding,
        child: Text(
          status.labelKey.tr(),
          style: AppTextStyles.xxxxxsMedium.copyWith(
            color: foreground,
            fontWeight: FontWeight.w700,
            height: _textHeight,
          ),
        ),
      ),
    );
  }
}
