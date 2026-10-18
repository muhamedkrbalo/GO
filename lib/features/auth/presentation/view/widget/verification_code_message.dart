import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/verify_code_cubit.dart';

class VerificationCodeMessage extends StatelessWidget {
  const VerificationCodeMessage({super.key});

  static const _minHeight = 68.8;

  String? _message(VerifyCodeState state) => switch (state.status) {
    VerifyCodeStatus.invalid => AppLocaleKey.incorrectCodeAttempts.plural(state.attemptsRemaining),
    VerifyCodeStatus.failure => state.errorMessage,
    _ => null,
  };

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: _minHeight, minWidth: double.infinity),
      child: BlocSelector<VerifyCodeCubit, VerifyCodeState, String?>(
        selector: _message,
        builder: (context, message) {
          if (message == null) return const SizedBox.shrink();
          return Padding(
            padding: const EdgeInsets.only(top: AppSpacing.l15),
            child: DecoratedBox(
              decoration: BoxDecoration(color: colors.errorSurface, borderRadius: AppRadius.brSm),
              child: Padding(
                padding: AppPadding.v10h15,
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.xsMedium.copyWith(color: colors.error, height: 1.45),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
