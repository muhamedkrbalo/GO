import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/buttons/custom_button.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../controller/verify_code_cubit.dart';

class VerifyCodeButton extends StatelessWidget {
  const VerifyCodeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<VerifyCodeCubit, VerifyCodeState, (bool, bool)>(
      selector: (state) => (state.canVerify, state.status == VerifyCodeStatus.verifying),
      builder: (context, button) {
        final (canVerify, isVerifying) = button;
        return CustomButton(
          text: AppLocaleKey.verifyCode.tr(),
          isEnabled: canVerify,
          isLoading: isVerifying,
          loaderColor: AppColors.primary,
          hasShadow: true,
          onPressed: context.read<VerifyCodeCubit>().verify,
        );
      },
    );
  }
}
