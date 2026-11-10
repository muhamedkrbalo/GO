import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import 'owner_home_empty_state.dart';
import 'owner_home_section_card.dart';
import 'owner_home_section_heading.dart';

class OwnerSubmittedUnitsCard extends StatelessWidget {
  const OwnerSubmittedUnitsCard({super.key});

  static const _viewAllMinSize = Size(0, 32);

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return OwnerHomeSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OwnerHomeSectionHeading(
            eyebrow: AppLocaleKey.independentReview.tr(),
            title: AppLocaleKey.mySubmittedUnits.tr(),
            trailing: TextButton(
              onPressed: () => context.goNamed(RouteNames.ownerUnits),
              style: TextButton.styleFrom(
                minimumSize: _viewAllMinSize,
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                foregroundColor: colors.oceanAccent,
                textStyle: AppTextStyles.xxxxxsMedium.copyWith(fontWeight: FontWeight.w800),
              ),
              child: Text(AppLocaleKey.viewAll.tr()),
            ),
          ),
          AppSpacing.gapV12,
          OwnerHomeEmptyState(
            title: AppLocaleKey.noSubmittedUnits.tr(),
            message: AppLocaleKey.submittedUnitsEmptyMessage.tr(),
          ),
        ],
      ),
    );
  }
}
