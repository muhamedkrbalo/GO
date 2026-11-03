import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/extension/int_extension.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/verify_code_cubit.dart';

class CodeExpiryLabel extends StatelessWidget {
  const CodeExpiryLabel({super.key});

  static const _minHeight = 38.0;
  static const _height = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: _minHeight),
      child: Center(
        child: BlocSelector<VerifyCodeCubit, VerifyCodeState, int>(
          selector: (state) => state.expiresIn,
          builder: (context, expiresIn) => Text(
            expiresIn > 0
                ? AppLocaleKey.codeExpiresIn.tr(args: [expiresIn.asCountdown])
                : AppLocaleKey.codeExpired.tr(),
            textAlign: TextAlign.center,
            style: AppTextStyles.xxsSemiBold.copyWith(
              color: expiresIn > 0 ? colors.textMuted : colors.error,
              height: _height,
            ),
          ),
        ),
      ),
    );
  }
}
