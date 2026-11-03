import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/custom_widgets/buttons/custom_button.dart';
import '../../../../../core/images/app_images.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/business_role.dart';
import '../../controller/business_role_cubit.dart';

class BusinessRoleContinueButton extends StatelessWidget {
  const BusinessRoleContinueButton({super.key});

  static const _height = 52.0;
  static const _radius = 12.0;
  static const _iconSize = 19.0;
  static const _textHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return BlocBuilder<BusinessRoleCubit, BusinessRole?>(
      builder: (context, selected) {
        final isEnabled = selected != null;
        final foreground = isEnabled ? colors.onPrimary : colors.hint;

        return CustomButton(
          text: AppLocaleKey.continue_.tr(),
          height: _height,
          radius: _radius,
          hasShadow: true,
          isEnabled: isEnabled,
          disabledColor: colors.subtleBorder,
          disabledBorderColor: colors.subtleBorder,
          style: AppTextStyles.sBold.copyWith(color: foreground, height: _textHeight),
          suffixIcon: Padding(
            padding: const EdgeInsetsDirectional.only(start: AppSpacing.xs5),
            child: SvgPicture.asset(
              AppImages.assetsSvgArrowForward,
              width: _iconSize,
              height: _iconSize,
              matchTextDirection: true,
              colorFilter: ColorFilter.mode(foreground, BlendMode.srcIn),
            ),
          ),
          onPressed: selected == BusinessRole.owner
              ? () => context.pushNamed(RouteNames.ownerType)
              : null,
        );
      },
    );
  }
}
