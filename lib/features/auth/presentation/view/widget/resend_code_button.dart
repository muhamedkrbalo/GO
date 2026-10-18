import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/verify_code_cubit.dart';

class ResendCodeButton extends StatelessWidget {
  const ResendCodeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<VerifyCodeCubit, VerifyCodeState, (bool, int)>(
      selector: (state) => (state.canResend, state.resendIn),
      builder: (context, resend) {
        final (canResend, seconds) = resend;
        return AuthTextButton(
          label: seconds > 0
              ? AppLocaleKey.resendCodeIn.tr(args: ['$seconds'])
              : AppLocaleKey.resendCode.tr(),
          onPressed: canResend ? context.read<VerifyCodeCubit>().resendCode : null,
        );
      },
    );
  }
}

class AuthTextButton extends StatelessWidget {
  const AuthTextButton({super.key, required this.label, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  static const _minSize = Size(64, 44);

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        minimumSize: _minSize,
        foregroundColor: colors.accentText,
        disabledForegroundColor: colors.textMuted,
        textStyle: AppTextStyles.xsBold,
      ),
      child: Text(label),
    );
  }
}
