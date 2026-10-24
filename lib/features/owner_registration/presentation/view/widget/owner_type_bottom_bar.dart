import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/custom_widgets/buttons/custom_button.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/owner_type.dart';
import '../../controller/owner_type_cubit.dart';
import 'registration_bottom_bar.dart';

class OwnerTypeBottomBar extends StatelessWidget {
  const OwnerTypeBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return RegistrationBottomBar(
      children: [
        BlocBuilder<OwnerTypeCubit, OwnerType?>(
          builder: (context, selected) => CustomButton(
            text: AppLocaleKey.continue_.tr(),
            isEnabled: selected != null,
            hasShadow: true,
            onPressed: selected == OwnerType.individual
                ? () => context.pushNamed(RouteNames.individualInfo)
                : null,
          ),
        ),
        AppSpacing.gapV10,
        Text(
          AppLocaleKey.reviewBeforeSubmitting.tr(),
          textAlign: TextAlign.center,
          style: AppTextStyles.xxsRegular.copyWith(color: colors.textMuted, height: 1.4),
        ),
      ],
    );
  }
}
