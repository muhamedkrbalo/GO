import 'package:flutter/material.dart';

import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/owner_home_overview.dart';
import '../widget/owner_application_overview_card.dart';
import '../widget/owner_home_header.dart';
import '../widget/owner_home_intro.dart';
import '../widget/owner_quick_actions.dart';
import '../widget/owner_recent_activity_card.dart';
import '../widget/owner_submitted_units_card.dart';
import '../widget/owner_subscription_card.dart';

class OwnerHomeScreen extends StatelessWidget {
  const OwnerHomeScreen({super.key, this.overview = OwnerHomeOverview.empty});

  final OwnerHomeOverview overview;

  static const _contentPadding = EdgeInsetsDirectional.fromSTEB(20, 22, 20, 28);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.customColors.canvas,
      body: Column(
        children: [
          const OwnerHomeHeader(),
          Expanded(
            child: ListView(
              padding: _contentPadding,
              children: [
                const OwnerHomeIntro(),
                AppSpacing.gapV16,
                OwnerApplicationOverviewCard(overview: overview),
                AppSpacing.gapV16,
                const OwnerSubmittedUnitsCard(),
                AppSpacing.gapV16,
                OwnerSubscriptionCard(hasActiveSubscription: overview.hasActiveSubscription),
                AppSpacing.gapV16,
                OwnerQuickActions(hasRequiredCorrections: overview.hasRequiredCorrections),
                AppSpacing.gapV16,
                const OwnerRecentActivityCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
