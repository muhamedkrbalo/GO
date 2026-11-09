import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/owner_navigation_tab.dart';

class OwnerTabPlaceholderScreen extends StatelessWidget {
  const OwnerTabPlaceholderScreen({super.key, required this.tab});

  final OwnerNavigationTab tab;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Scaffold(
      backgroundColor: colors.canvas,
      body: Center(
        child: Text(
          tab.labelKey.tr(),
          style: AppTextStyles.xlBold.copyWith(color: colors.textPrimary),
        ),
      ),
    );
  }
}
