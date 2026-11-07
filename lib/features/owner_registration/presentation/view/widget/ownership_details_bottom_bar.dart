import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/custom_widgets/buttons/custom_button.dart';
import '../../../../../core/custom_widgets/buttons/primary_arrow_button.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/owner_registration_draft_cubit.dart';
import '../../controller/ownership_details_cubit.dart';
import 'registration_sticky_footer.dart';

class OwnershipDetailsBottomBar extends StatelessWidget {
  const OwnershipDetailsBottomBar({super.key});

  static const _saveFlex = 2;
  static const _continueFlex = 3;
  static const _buttonHeight = 52.0;
  static const _buttonRadius = 12.0;
  static const _textHeight = 1.5;

  void _continue(BuildContext context) {
    final cubit = context.read<OwnershipDetailsCubit>()..continueToNextUnit();
    if (!cubit.state.isComplete) return;
    context.read<OwnerRegistrationDraftCubit>().saveOwnership(cubit.state.details);
    context.pushNamed(RouteNames.ownerDocuments, extra: cubit.state.units);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return RegistrationStickyFooter(
      showSaveAndExit: false,
      child: BlocSelector<OwnershipDetailsCubit, OwnershipDetailsState, (bool, bool, bool)>(
        selector: (state) => (
          state.canSaveActive,
          state.savedIds.contains(state.activeUnit.id),
          state.isLastPendingUnit,
        ),
        builder: (context, actions) {
          final (canSave, isSaved, isLastPending) = actions;
          final canSaveNow = canSave && !isSaved;

          return Row(
            children: [
              Expanded(
                flex: _saveFlex,
                child: CustomButton(
                  text: AppLocaleKey.saveUnitDetails.tr(),
                  height: _buttonHeight,
                  radius: _buttonRadius,
                  color: colors.surface,
                  borderColor: colors.textPrimary,
                  disabledColor: colors.surface,
                  disabledBorderColor: colors.subtleBorder,
                  isEnabled: canSaveNow,
                  style: AppTextStyles.xxxsBold.copyWith(
                    color: canSaveNow ? colors.textPrimary : colors.hint,
                    height: _textHeight,
                  ),
                  onPressed: context.read<OwnershipDetailsCubit>().saveActiveUnit,
                ),
              ),
              AppSpacing.gapH10,
              Expanded(
                flex: _continueFlex,
                child: PrimaryArrowButton(
                  text: isLastPending
                      ? AppLocaleKey.continueToDocuments.tr()
                      : AppLocaleKey.continueToNextUnit.tr(),
                  textStyle: AppTextStyles.xxsBold,
                  isEnabled: canSave,
                  onPressed: () => _continue(context),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
