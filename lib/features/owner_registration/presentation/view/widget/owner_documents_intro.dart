import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class OwnerDocumentsIntro extends StatelessWidget {
  const OwnerDocumentsIntro({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocaleKey.documentVerification.tr(),
          style: AppTextStyles.xxsBold.copyWith(
            color: colors.textPrimary,
            letterSpacing: 0.8,
            height: 1.55,
          ),
        ),
        AppSpacing.gapV8,
        Text(
          AppLocaleKey.uploadYourDocuments.tr(),
          style: AppTextStyles.xxlBold.copyWith(
            color: colors.textSecondary,
            letterSpacing: -1,
            height: 1.2,
          ),
        ),
        AppSpacing.gapV10,
        Text(
          AppLocaleKey.uploadDocumentsDescription.tr(),
          style: AppTextStyles.sRegular.copyWith(color: colors.textMuted, height: 1.55),
        ),
      ],
    );
  }
}
