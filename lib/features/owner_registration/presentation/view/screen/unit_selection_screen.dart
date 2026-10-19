import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/info_banner/info_banner.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../widget/registration_progress_header.dart';
import '../widget/unit_filters.dart';
import '../widget/unit_list_header.dart';
import '../widget/unit_list_sliver.dart';
import '../widget/unit_search_field.dart';
import '../widget/unit_selection_bottom_bar.dart';
import '../widget/unit_selection_intro.dart';

class UnitSelectionScreen extends StatelessWidget {
  const UnitSelectionScreen({super.key});

  static const _step = 4;
  static const _progress = 0.65;
  static const _contentPadding = EdgeInsets.fromLTRB(20, 24, 20, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.customColors.canvas,
      bottomNavigationBar: const UnitSelectionBottomBar(),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            RegistrationProgressHeader(
              step: _step,
              progress: _progress,
              completedLabel: AppLocaleKey.ownerAddressComplete.tr(),
            ),
            Expanded(
              child: CustomScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                slivers: [
                  SliverPadding(
                    padding: _contentPadding,
                    sliver: SliverList.list(
                      children:const [
                         UnitSelectionIntro(),
                        AppSpacing.gapV24,
                         UnitSearchField(),
                        AppSpacing.gapV10,
                         UnitFilters(),
                         UnitListHeader(),
                        AppSpacing.gapV12,
                        InfoBanner( ),
                        AppSpacing.gapV12,
                      ],
                    ),
                  ),
                  const UnitListSliver(),
                  const SliverToBoxAdapter(child: AppSpacing.gapV24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
