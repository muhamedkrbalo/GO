import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/ownership_details_cubit.dart';
import '../widget/ownership_details_bottom_bar.dart';
import '../widget/ownership_details_header.dart';
import '../widget/ownership_details_intro.dart';
import '../widget/ownership_review_notice.dart';
import '../widget/ownership_unit_card.dart';
import '../widget/registration_progress_header.dart';
import '../widget/selected_units_summary.dart';

class OwnershipDetailsScreen extends StatelessWidget {
  const OwnershipDetailsScreen({super.key});

  static const _step = 5;
  static const _progress = 0.8;
  static const _introPadding = EdgeInsets.fromLTRB(20, 24, 20, 0);
  static const _listPadding = EdgeInsets.symmetric(horizontal: 20);
  static const _noticePadding = EdgeInsets.fromLTRB(20, 16, 20, 24);

  @override
  Widget build(BuildContext context) {
    final units = context.read<OwnershipDetailsCubit>().state.units;

    return Scaffold(
      backgroundColor: context.customColors.canvas,
      bottomNavigationBar: const OwnershipDetailsBottomBar(),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            RegistrationProgressHeader(
              step: _step,
              progress: _progress,
              completedLabel: AppLocaleKey.unitsSelectedComplete.tr(),
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: _introPadding,
                    sliver: SliverList.list(
                      children: [
                        const OwnershipDetailsIntro(),
                        AppSpacing.gapV20,
                        SelectedUnitsSummary(units: units),
                        AppSpacing.gapV20,
                        const OwnershipDetailsHeader(),
                        AppSpacing.gapV10,
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: _listPadding,
                    sliver: SliverList.separated(
                      itemCount: units.length,
                      separatorBuilder: (_, _) => AppSpacing.gapV12,
                      itemBuilder: (context, index) => OwnershipUnitCard(
                        key: ValueKey(units[index].id),
                        unit: units[index],
                        initiallyExpanded: index == 0,
                      ),
                    ),
                  ),
                  const SliverPadding(
                    padding: _noticePadding,
                    sliver: SliverToBoxAdapter(child: OwnershipReviewNotice()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
