import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/custom_widgets/buttons/primary_arrow_button.dart';
import '../../../../../core/custom_widgets/registration_form/registration_sticky_footer.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/owner_unit.dart';
import '../../controller/unit_selection_cubit.dart';

class UnitSelectionBottomBar extends StatelessWidget {
  const UnitSelectionBottomBar({super.key});

  static const _topPadding = 10.0;
  static const _buttonGap = SizedBox(height: 9);

  Future<void> _review(BuildContext context) async {
    final cubit = context.read<UnitSelectionCubit>();
    final remaining = await context.pushNamed<List<OwnerUnit>>(
      RouteNames.selectedUnitsReview,
      extra: cubit.state.selectedUnits,
    );
    if (remaining == null || cubit.isClosed) return;
    cubit.keepSelected(remaining.map((unit) => unit.id));
  }

  @override
  Widget build(BuildContext context) {
    return RegistrationStickyFooter(
      topPadding: _topPadding,
      child: BlocSelector<UnitSelectionCubit, UnitSelectionState, int>(
        selector: (state) => state.selectedCount,
        builder: (context, selectedCount) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _SelectedUnitsCount(count: selectedCount),
            _buttonGap,
            PrimaryArrowButton(
              text: AppLocaleKey.continue_.tr(),
              isEnabled: selectedCount > 0,
              onPressed: () => _review(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectedUnitsCount extends StatelessWidget {
  const _SelectedUnitsCount({required this.count});

  final int count;

  static const _pillHeight = 24.0;
  static const _pillMinWidth = 28.0;
  static const _pillPadding = EdgeInsetsDirectional.symmetric(horizontal: 8);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Row(
      children: [
        Expanded(
          child: Text(
            AppLocaleKey.selectedUnits.tr(),
            style: AppTextStyles.xxxsSemiBold.copyWith(
              color: colors.textMuted,
              height: _textHeight,
            ),
          ),
        ),
        Container(
          height: _pillHeight,
          constraints: const BoxConstraints(minWidth: _pillMinWidth),
          padding: _pillPadding,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: colors.oceanAccent, borderRadius: AppRadius.brCircle),
          child: Text(
            '$count',
            style: AppTextStyles.xxsBold.copyWith(
              color: colors.onPrimary,
              fontWeight: FontWeight.w900,
              height: _textHeight,
            ),
          ),
        ),
      ],
    );
  }
}
