import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/selectable_option_card/selectable_option_card.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/owner_type.dart';
import '../../controller/owner_type_cubit.dart';
import '../widget/owner_registration_step_header.dart';
import '../widget/owner_type_continue_button.dart';
import '../widget/owner_type_intro.dart';

class OwnerTypeScreen extends StatelessWidget {
  const OwnerTypeScreen({super.key});

  static const _step = 1;
  static const _progress = 0.25;
  static const _contentPadding = EdgeInsetsDirectional.fromSTEB(24, 34, 24, 38);
  static const _introToCardsGap = 30.0;
  static const _cardsGap = 14.0;
  static const _cardsToButtonGap = 28.0;
  static const _buttonToNoteGap = 11.0;
  static const _maxNoteWidth = 300.0;
  static const _noteHeight = 1.45;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Scaffold(
      backgroundColor: colors.canvas,
      body: Column(
        children: [
          OwnerRegistrationStepHeader(
            stepLabel: AppLocaleKey.stepNumber.tr(args: ['$_step']),
            stepTitle: AppLocaleKey.ownerType.tr(),
            stepHint: AppLocaleKey.firstStep.tr(),
            progress: _progress,
          ),
          Expanded(
            child: SafeArea(
              top: false,
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: _contentPadding,
                    sliver: SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const OwnerTypeIntro(),
                          const SizedBox(height: _introToCardsGap),
                          for (final type in OwnerType.values) ...[
                            if (type.index > 0) const SizedBox(height: _cardsGap),
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
                          const Spacer(),
                          const SizedBox(height: _cardsToButtonGap),
                          const OwnerTypeContinueButton(),
                          const SizedBox(height: _buttonToNoteGap),
                          Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: _maxNoteWidth),
                              child: Text(
                                AppLocaleKey.selectionDefinesNextStepNote.tr(),
                                textAlign: TextAlign.center,
                                style: AppTextStyles.xxxxsRegular.copyWith(
                                  color: colors.hint,
                                  height: _noteHeight,
                                ),
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
          ),
        ],
      ),
    );
  }
}
