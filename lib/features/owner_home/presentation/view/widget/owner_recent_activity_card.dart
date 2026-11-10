import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import 'owner_home_empty_state.dart';
import 'owner_home_section_card.dart';
import 'owner_home_section_heading.dart';

class OwnerRecentActivityCard extends StatelessWidget {
  const OwnerRecentActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return OwnerHomeSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OwnerHomeSectionHeading(
            eyebrow: AppLocaleKey.updates.tr(),
            title: AppLocaleKey.notificationsAndRecentActivity.tr(),
          ),
          AppSpacing.gapV10,
          OwnerHomeEmptyState(
            title: AppLocaleKey.noRecentActivity.tr(),
            message: AppLocaleKey.recentActivityEmptyMessage.tr(),
          ),
        ],
      ),
    );
  }
}
