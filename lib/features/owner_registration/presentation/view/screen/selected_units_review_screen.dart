import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/custom_widgets/registration_form/registration_intro.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/selected_units_review_cubit.dart';
import '../widget/owner_registration_step_header.dart';
import '../widget/selected_units_review_bottom_bar.dart';
import '../widget/selected_units_review_sliver.dart';
import '../widget/selected_units_section_header.dart';
import '../widget/selection_stats_card.dart';

class SelectedUnitsReviewScreen extends StatelessWidget {
  const SelectedUnitsReviewScreen({super.key});

  static const _step = 5;
  static const _stepCount = 8;
  static const _progress = 0.625;
  static const _contentPadding = EdgeInsetsDirectional.fromSTEB(20, 24, 20, 26);
  static const _statsGap = SizedBox(height: 22);

  @override
  Widget build(BuildContext context) {
    return _ReturnSelectionOnPop(
      child: Scaffold(
        backgroundColor: context.customColors.canvas,
        bottomNavigationBar: const SelectedUnitsReviewBottomBar(),
        body: Column(
          children: [
            OwnerRegistrationStepHeader(
              stepLabel: AppLocaleKey.stepXOfY.tr(args: ['$_step', '$_stepCount']),
              progress: _progress,
              onBack: () => Navigator.maybePop(context),
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: _contentPadding,
                    sliver: SliverMainAxisGroup(
                      slivers: [
                        SliverList.list(
                          children: [
                            RegistrationIntro(
                              eyebrow: AppLocaleKey.selectionReview.tr(),
                              title: AppLocaleKey.reviewSelectedUnits.tr(),
                              subtitle: AppLocaleKey.reviewSelectedUnitsDescription.tr(),
                            ),
                            _statsGap,
                            const SelectionStatsCard(),
                            AppSpacing.gapV24,
                            const SelectedUnitsSectionHeader(),
                            AppSpacing.gapV12,
                          ],
                        ),
                        const SelectedUnitsReviewSliver(),
                      ],
                    ),
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

class _ReturnSelectionOnPop extends StatelessWidget {
  const _ReturnSelectionOnPop({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SelectedUnitsReviewCubit, SelectedUnitsReviewState, bool>(
      selector: (state) => state.hasChanges,
      builder: (context, hasChanges) => PopScope<Object?>(
        canPop: !hasChanges,
        onPopInvokedWithResult: (didPop, _) {
          if (didPop) return;
          context.pop(context.read<SelectedUnitsReviewCubit>().state.units);
        },
        child: child,
      ),
    );
  }
}
