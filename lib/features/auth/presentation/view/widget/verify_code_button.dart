import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/custom_widgets/buttons/custom_button.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/verify_code_cubit.dart';

class VerifyCodeButton extends StatelessWidget {
  const VerifyCodeButton({super.key});

  static const _height = 52.0;
  static const _radius = 12.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return BlocSelector<VerifyCodeCubit, VerifyCodeState, bool>(
      selector: (state) => state.canVerify,
      builder: (context, canVerify) => CustomButton(
        text: AppLocaleKey.verifyAccount.tr(),
        height: _height,
        radius: _radius,
        hasShadow: true,
        isEnabled: canVerify,
        disabledColor: colors.subtleBorder,
        disabledBorderColor: colors.subtleBorder,
        disabledTextColor: colors.grey,
        onPressed: () => context.goNamed(RouteNames.businessRole),
      ),
    );
  }
}
