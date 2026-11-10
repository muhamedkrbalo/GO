import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/status_pill/review_status_pill.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../../auth/data/model/business_role.dart';
import '../../../data/model/owner_subscription.dart';
import 'package_details_section_card.dart';

class CoveredRelationshipsCard extends StatelessWidget {
  const CoveredRelationshipsCard({super.key, required this.relationships});

  final List<BusinessRole> relationships;

  static const _chipSpacing = 6.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return PackageDetailsSectionCard(
      title: AppLocaleKey.coveredBusinessRelationships.tr(),
      child: Wrap(
        spacing: _chipSpacing,
        runSpacing: _chipSpacing,
        children: [
          for (final relationship in relationships)
            ReviewStatusPill(
              label: relationship.shortLabelKey.tr(),
              background: colors.iconTileSurface,
              foreground: colors.oceanAccent,
            ),
        ],
      ),
    );
  }
}
