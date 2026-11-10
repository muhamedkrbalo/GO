import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import 'package_details_section_card.dart';
import 'package_info_row.dart';

class PackageResourceLimitsCard extends StatelessWidget {
  const PackageResourceLimitsCard({
    super.key,
    required this.unitsLimit,
    required this.businessUsersLimit,
  });

  final int unitsLimit;
  final int businessUsersLimit;

  @override
  Widget build(BuildContext context) {
    return PackageDetailsSectionCard(
      title: AppLocaleKey.resourceLimits.tr(),
      titleGap: 0,
      child: Column(
        children: [
          PackageInfoRow(label: AppLocaleKey.units.tr(), value: '$unitsLimit', showDivider: true),
          PackageInfoRow(label: AppLocaleKey.businessUsers.tr(), value: '$businessUsersLimit'),
        ],
      ),
    );
  }
}
