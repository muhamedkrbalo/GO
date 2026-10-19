import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/custom_widgets/buttons/custom_button.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../controller/verify_code_cubit.dart';

class VerifyCodeButton extends StatelessWidget {
  const VerifyCodeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<VerifyCodeCubit, VerifyCodeState, bool>(
      selector: (state) => state.canVerify,
      builder: (context, canVerify) => CustomButton(
        text: AppLocaleKey.verifyCode.tr(),
        isEnabled: canVerify,
        hasShadow: true,
        onPressed: () => context.goNamed(RouteNames.businessRole),
      ),
    );
  }
}
