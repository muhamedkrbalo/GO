import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../widget/individual_info_bottom_bar.dart';
import '../widget/individual_info_form.dart';
import '../widget/registration_progress_header.dart';

class IndividualInfoScreen extends StatelessWidget {
  const IndividualInfoScreen({super.key});

  static const _step = 2;
  static const _progress = 0.25;
  static const _contentPadding = EdgeInsets.fromLTRB(20, 24, 20, 24);

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Form(
      child: Scaffold(
        backgroundColor: colors.canvas,
        bottomNavigationBar: const IndividualInfoBottomBar(),
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              RegistrationProgressHeader(
                step: _step,
                progress: _progress,
                completedLabel: AppLocaleKey.ownerTypeSelected.tr(),
              ),
              Expanded(
                child: ListView(
                  padding: _contentPadding,
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  children: [
                    Text(
                      AppLocaleKey.individualOwner.tr(),
                      style: AppTextStyles.xxsBold.copyWith(
                        color: colors.textPrimary,
                        letterSpacing: 0.8,
                        height: 1.55,
                      ),
                    ),
                    AppSpacing.gapV8,
                    Text(
                      AppLocaleKey.yourPersonalInformation.tr(),
                      style: AppTextStyles.xxlBold.copyWith(
                        color: colors.textSecondary,
                        letterSpacing: -1,
                        height: 1.2,
                      ),
                    ),
                    AppSpacing.gapV10,
                    Text(
                      AppLocaleKey.enterLegalDetails.tr(),
                      style: AppTextStyles.sRegular.copyWith(color: colors.textMuted, height: 1.55),
                    ),
                    AppSpacing.gapV24,
                    const IndividualInfoForm(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
