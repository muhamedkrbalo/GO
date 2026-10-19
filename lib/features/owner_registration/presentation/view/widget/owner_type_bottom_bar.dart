import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widgets/buttons/custom_button.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/owner_type.dart';
import '../../controller/owner_type_cubit.dart';

class OwnerTypeBottomBar extends StatelessWidget {
  const OwnerTypeBottomBar({super.key});

  static const _padding = EdgeInsets.fromLTRB(20, 16, 20, 17.6);
  static const _borderWidth = 1.6;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(
          top: BorderSide(color: colors.subtleBorder, width: _borderWidth),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: _padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocSelector<OwnerTypeCubit, OwnerType?, bool>(
                selector: (selected) => selected != null,
                builder: (context, hasSelection) => CustomButton(
                  text: AppLocaleKey.continue_.tr(),
                  isEnabled: hasSelection,
                  hasShadow: true,
                ),
              ),
              AppSpacing.gapV10,
              Text(
                AppLocaleKey.reviewBeforeSubmitting.tr(),
                textAlign: TextAlign.center,
                style: AppTextStyles.xxsRegular.copyWith(color: colors.textMuted, height: 1.4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
