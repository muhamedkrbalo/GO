import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hr_erb/features/auth/presentation/view/widget/business_role_header.dart';

import '../../../../../core/custom_widgets/buttons/custom_button.dart';
import '../../../../../core/images/app_images.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/business_role.dart';
import '../../controller/business_role_cubit.dart';
import '../widget/account_verified_badge.dart';
import '../widget/business_role_card.dart';

class BusinessRoleScreen extends StatelessWidget {
  const BusinessRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: AppPadding.t15h24b24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BusinessRoleHeader(),
                    AppSpacing.gapV40,
                    Text(
                      AppLocaleKey.businessRegistration.tr(),
                      style: AppTextStyles.xxsBold.copyWith(
                        color: colors.textPrimary,
                        letterSpacing: 1.6,
                        height: 1.4,
                      ),
                    ),
                    AppSpacing.gapV12,
                    Text(
                      AppLocaleKey.howWillYouUseGo.tr(),
                      style: AppTextStyles.xxxlBold.copyWith(
                        color: colors.textSecondary,
                        letterSpacing: -1.4,
                        height: 1.18,
                      ),
                    ),
                    AppSpacing.gapV12,
                    Text(
                      AppLocaleKey.chooseBusinessRelationship.tr(),
                      style: AppTextStyles.sRegular.copyWith(
                        color: colors.textMuted,
                        height: 1.6,
                      ),
                    ),
                    AppSpacing.gapV32,
                    for (final role in BusinessRole.values) ...[
                      if (role.index > 0) AppSpacing.gapV12,
                      BlocSelector<BusinessRoleCubit, BusinessRole?, bool>(
                        selector: (selected) => selected == role,
                        builder: (context, isSelected) => BusinessRoleCard(
                          role: role,
                          isSelected: isSelected,
                          onTap: () => context
                              .read<BusinessRoleCubit>()
                              .selectRole(role),
                        ),
                      ),
                    ],
                    AppSpacing.gapV15,
                    Center(
                      child: Text(
                        AppLocaleKey.businessSelectionNote.tr(),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.xxsRegular.copyWith(
                          color: colors.textMuted,
                          height: 1.45,
                        ),
                      ),
                    ),
                    const Spacer(),
                    AppSpacing.gapV24,
                    BlocSelector<BusinessRoleCubit, BusinessRole?, bool>(
                      selector: (selected) => selected != null,
                      builder: (context, hasSelection) => CustomButton(
                        text: AppLocaleKey.continue_.tr(),
                        isEnabled: hasSelection,
                        hasShadow: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}