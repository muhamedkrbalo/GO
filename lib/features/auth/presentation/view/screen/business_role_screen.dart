import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/business_role.dart';
import '../../controller/business_role_cubit.dart';
import '../widget/account_verified_banner.dart';
import '../widget/business_role_card.dart';
import '../widget/business_role_continue_button.dart';
import '../widget/business_role_header.dart';
import '../widget/business_role_intro.dart';

class BusinessRoleScreen extends StatelessWidget {
  const BusinessRoleScreen({super.key});

  static const _contentPadding = EdgeInsetsDirectional.fromSTEB(24, 20, 24, 38);
  static const _ringSize = 260.0;
  static const _ringTop = -104.0;
  static const _ringEnd = -124.0;
  static const _ringOpacity = 0.16;
  static const _bannerToIntroGap = 28.0;
  static const _introToCardsGap = 26.0;
  static const _cardsToButtonGap = 26.0;
  static const _buttonToNoteGap = 11.0;
  static const _noteHeight = 1.4;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Scaffold(
      backgroundColor: colors.canvas,
      body: SafeArea(
        child: Stack(
          children: [
            PositionedDirectional(
              top: _ringTop,
              end: _ringEnd,
              child: Container(
                width: _ringSize,
                height: _ringSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: colors.cyanAccent.withValues(alpha: _ringOpacity)),
                ),
              ),
            ),
            Column(
              children: [
                const BusinessRoleHeader(),
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: _contentPadding,
                        sliver: SliverFillRemaining(
                          hasScrollBody: false,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AccountVerifiedBanner(),
                              const SizedBox(height: _bannerToIntroGap),
                              const BusinessRoleIntro(),
                              const SizedBox(height: _introToCardsGap),
                              for (final role in BusinessRole.values) ...[
                                if (role.index > 0) AppSpacing.gapV12,
                                BlocSelector<BusinessRoleCubit, BusinessRole?, bool>(
                                  selector: (selected) => selected == role,
                                  builder: (context, isSelected) => BusinessRoleCard(
                                    role: role,
                                    isSelected: isSelected,
                                    onTap: () => context.read<BusinessRoleCubit>().selectRole(role),
                                  ),
                                ),
                              ],
                              const Spacer(),
                              const SizedBox(height: _cardsToButtonGap),
                              const BusinessRoleContinueButton(),
                              const SizedBox(height: _buttonToNoteGap),
                              Center(
                                child: Text(
                                  AppLocaleKey.addRelationshipsLaterNote.tr(),
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.xxxxsRegular.copyWith(
                                    color: colors.hint,
                                    height: _noteHeight,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
