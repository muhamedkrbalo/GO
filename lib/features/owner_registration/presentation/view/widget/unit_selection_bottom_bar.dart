import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/custom_widgets/buttons/primary_arrow_button.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/unit_selection_cubit.dart';

class UnitSelectionBottomBar extends StatelessWidget {
  const UnitSelectionBottomBar({super.key});

  static const _padding = EdgeInsetsDirectional.fromSTEB(20, 10, 20, 4);
  static const _backgroundOpacity = 0.97;
  static const _buttonGap = SizedBox(height: 9);
  static const _exitMinSize = Size(0, 44);
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: _backgroundOpacity),
        border: Border(top: BorderSide(color: colors.subtleBorder)),
        boxShadow: AppShadows.stickyFooter,
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: _padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocSelector<UnitSelectionCubit, UnitSelectionState, int>(
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
                      onPressed: () => context.pushNamed(
                        RouteNames.ownershipDetails,
                        extra: context.read<UnitSelectionCubit>().state.selectedUnits,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextButton(
                  onPressed: () => context.goNamed(RouteNames.welcome),
                  style: TextButton.styleFrom(
                    minimumSize: _exitMinSize,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    foregroundColor: colors.textPrimary,
                    textStyle: AppTextStyles.xsBold.copyWith(height: _textHeight),
                  ),
                  child: Text(AppLocaleKey.saveAndExit.tr()),
                ),
              ),
            ],
          ),
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
