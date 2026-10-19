import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/selectable_option_card/selectable_option_card.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/owner_type.dart';
import '../../controller/owner_type_cubit.dart';
import '../widget/owner_registration_header.dart';
import '../widget/owner_type_bottom_bar.dart';
import '../widget/registration_step_card.dart';

class OwnerTypeScreen extends StatelessWidget {
  const OwnerTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Scaffold(
      backgroundColor: colors.canvas,
      bottomNavigationBar: const OwnerTypeBottomBar(),
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: AppPadding.t12h20,
          children: [
            const OwnerRegistrationHeader(),
            AppSpacing.gapV16,
            RegistrationStepCard(
              step: 1,
              title: AppLocaleKey.ownerRegistration.tr(),
              subtitle: AppLocaleKey.setUpOwnerProfile.tr(),
            ),
            AppSpacing.gapV32,
            Text(
              AppLocaleKey.howAreYouRegistering.tr(),
              style: AppTextStyles.xxlBold.copyWith(
                color: colors.textSecondary,
                letterSpacing: -1.1,
                height: 1.2,
              ),
            ),
            AppSpacing.gapV10,
            Text(
              AppLocaleKey.chooseOwnerType.tr(),
              style: AppTextStyles.sRegular.copyWith(color: colors.textMuted, height: 1.55),
            ),
            AppSpacing.gapV24,
            for (final type in OwnerType.values) ...[
              if (type.index > 0) AppSpacing.gapV12,
              BlocSelector<OwnerTypeCubit, OwnerType?, bool>(
                selector: (selected) => selected == type,
                builder: (context, isSelected) => SelectableOptionCard(
                  icon: type.icon,
                  title: type.titleKey.tr(),
                  description: type.descriptionKey.tr(),
                  isSelected: isSelected,
                  onTap: () => context.read<OwnerTypeCubit>().selectType(type),
                ),
              ),
            ],
            AppSpacing.gapV24,
          ],
        ),
      ),
    );
  }
}
