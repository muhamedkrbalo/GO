import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/registration_form/registration_intro.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/registration_status_cubit.dart';
import '../widget/overall_status_card.dart';
import '../widget/prototype_data_pill.dart';
import '../widget/registration_notice.dart';
import '../widget/registration_status_header.dart';
import '../widget/review_filter_bar.dart';
import '../widget/unit_reviews_sliver.dart';

class RegistrationStatusScreen extends StatelessWidget {
  const RegistrationStatusScreen({super.key});

  static const _topPadding = EdgeInsetsDirectional.fromSTEB(20, 24, 20, 20);
  static const _listPadding = EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0);
  static const _bottomPadding = EdgeInsetsDirectional.fromSTEB(20, 18, 20, 36);
  static const _pillGap = SizedBox(height: 9);
  static const _headerGap = SizedBox(height: 11);

  @override
  Widget build(BuildContext context) {
    final state = context.read<RegistrationStatusCubit>().state;

    return Scaffold(
      backgroundColor: context.customColors.canvas,
      body: Column(
        children: [
          const RegistrationStatusHeader(),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: _topPadding,
                  sliver: SliverList.list(
                    children: [
                      RegistrationIntro(
                        eyebrow: AppLocaleKey.independentUnitReview.tr(),
                        title: AppLocaleKey.registrationStatus.tr(),
                        subtitle: AppLocaleKey.registrationStatusDescription.tr(),
                      ),
                      _pillGap,
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: PrototypeDataPill(label: AppLocaleKey.prototypeReviewData.tr()),
                      ),
                      AppSpacing.gapV20,
                      OverallStatusCard(receipt: state.receipt, status: state.overallStatus),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(child: ReviewFilterBar()),
                const SliverPadding(
                  padding: _listPadding,
                  sliver: SliverMainAxisGroup(
                    slivers: [
                      SliverToBoxAdapter(child: UnitReviewsHeader()),
                      SliverToBoxAdapter(child: _headerGap),
                      UnitReviewsSliver(),
                    ],
                  ),
                ),
                SliverPadding(
                  padding: _bottomPadding,
                  sliver: SliverToBoxAdapter(
                    child: RegistrationNotice(
                      message: AppLocaleKey.unitsReviewedIndependentlyNote.tr(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
