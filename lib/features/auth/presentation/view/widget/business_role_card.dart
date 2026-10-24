import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/selectable_option_card/selectable_option_card.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../data/model/business_role.dart';

class BusinessRoleCard extends StatelessWidget {
  const BusinessRoleCard({
    super.key,
    required this.role,
    required this.isSelected,
    required this.onTap,
  });

  final BusinessRole role;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SelectableOptionCard(
      icon: role.icon,
      title: role.titleKey.tr(),
      description: role.descriptionKey.tr(),
      isSelected: isSelected,
      onTap: onTap,
      padding: AppPadding.v16h16,
      minHeight: 115.2,
      iconTileSize: 44.8,
      iconSize: 22.4,
      iconTileRadius: const BorderRadius.all(Radius.circular(13.6)),
    );
  }
}
