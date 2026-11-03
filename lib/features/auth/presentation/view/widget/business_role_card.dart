import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/selectable_option_card/selectable_option_card.dart';
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
      padding: const EdgeInsetsDirectional.all(16),
      minHeight: 106,
      borderRadius: const BorderRadius.all(Radius.circular(14)),
      iconTileSize: 50,
      iconSize: 24,
      iconTileRadius: const BorderRadius.all(Radius.circular(13)),
      gap: 14,
      titleToDescriptionGap: 6,
      indicatorSize: 21,
    );
  }
}
