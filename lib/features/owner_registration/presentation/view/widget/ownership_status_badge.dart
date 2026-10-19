import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class OwnershipStatusBadge extends StatelessWidget {
  const OwnershipStatusBadge({super.key, required this.isComplete});

  final bool isComplete;

  static const _padding = EdgeInsets.symmetric(horizontal: 6.4, vertical: 4);

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isComplete ? colors.primaryLight : colors.warningSurface,
        borderRadius: AppRadius.brCircle,
      ),
      child: Padding(
        padding: _padding,
        child: Text(
          isComplete ? AppLocaleKey.detailsComplete.tr() : AppLocaleKey.detailsRequired.tr(),
          style: AppTextStyles.xxxsBold.copyWith(
            color: isComplete ? colors.accentText : colors.warning,
            height: 1.3,
          ),
        ),
      ),
    );
  }
}
