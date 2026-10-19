import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/buttons/custom_button.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/unit_selection_cubit.dart';
import 'registration_bottom_bar.dart';

class UnitSelectionBottomBar extends StatelessWidget {
  const UnitSelectionBottomBar({super.key});

  static const _buttonWidth = 160.0;
  static const _buttonHeight = 48.8;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return RegistrationBottomBar(
      children: [
        BlocSelector<UnitSelectionCubit, UnitSelectionState, int>(
          selector: (state) => state.selectedCount,
          builder: (context, selectedCount) => Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$selectedCount',
                      style: AppTextStyles.mBold.copyWith(color: colors.textSecondary),
                    ),
                    const SizedBox(height: AppSpacing.xxs2),
                    Text(
                      AppLocaleKey.unitsSelected.tr(),
                      style: AppTextStyles.xxxsMedium.copyWith(color: colors.textMuted),
                    ),
                  ],
                ),
              ),
              AppSpacing.gapH16,
              CustomButton(
                text: AppLocaleKey.continue_.tr(),
                width: _buttonWidth,
                height: _buttonHeight,
                isEnabled: selectedCount > 0,
                hasShadow: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
