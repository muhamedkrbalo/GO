import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/buttons/custom_button.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/registration_review_cubit.dart';
import 'registration_sticky_footer.dart';

class RegistrationReviewBottomBar extends StatelessWidget {
  const RegistrationReviewBottomBar({super.key});

  static const _buttonHeight = 52.0;
  static const _buttonRadius = 12.0;
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return RegistrationStickyFooter(
      child: BlocSelector<RegistrationReviewCubit, RegistrationReviewState, bool>(
        selector: (state) => state.canSubmit,
        builder: (context, canSubmit) => CustomButton(
          text: AppLocaleKey.submitRegistration.tr(),
          height: _buttonHeight,
          radius: _buttonRadius,
          hasShadow: true,
          onPressed: context.read<RegistrationReviewCubit>().submit,
          //isEnabled: canSubmit,
          isEnabled: true,
          disabledColor: colors.subtleBorder,
          disabledBorderColor: colors.subtleBorder,
          style: AppTextStyles.sBold.copyWith(
            color:colors.onPrimary,
            //color: canSubmit ? colors.onPrimary : colors.hint,
            height: _textHeight,
          ),
        ),
      ),
    );
  }
}
