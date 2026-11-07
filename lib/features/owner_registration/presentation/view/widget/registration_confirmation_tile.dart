import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../controller/registration_review_cubit.dart';

class RegistrationConfirmationTile extends StatelessWidget {
  const RegistrationConfirmationTile({super.key});

  static const _padding = EdgeInsetsDirectional.all(14);
  static const _radius = BorderRadius.all(Radius.circular(12));
  static const _boxSize = 21.0;
  static const _boxRadius = BorderRadius.all(Radius.circular(6));
  static const _iconSize = 12.0;
  static const _duration = Duration(milliseconds: 160);
  static const _textHeight = 1.55;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final cubit = context.read<RegistrationReviewCubit>();

    return BlocSelector<RegistrationReviewCubit, RegistrationReviewState, bool>(
      selector: (state) => state.isConfirmed,
      builder: (context, isConfirmed) => Semantics(
        checked: isConfirmed,
        child: Material(
          color: colors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: _radius,
            side: BorderSide(color: isConfirmed ? colors.oceanAccent : colors.subtleBorder),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => cubit.setConfirmed(!isConfirmed),
            child: Padding(
              padding: _padding,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedContainer(
                    duration: _duration,
                    width: _boxSize,
                    height: _boxSize,
                    decoration: BoxDecoration(
                      color: isConfirmed ? colors.oceanAccent : colors.surface,
                      borderRadius: _boxRadius,
                      border: Border.all(color: isConfirmed ? colors.oceanAccent : colors.border),
                    ),
                    child: isConfirmed
                        ? Center(
                            child: SvgPicture.asset(
                              AppImages.assetsSvgCheck,
                              width: _iconSize,
                              height: _iconSize,
                              colorFilter: ColorFilter.mode(colors.onPrimary, BlendMode.srcIn),
                            ),
                          )
                        : null,
                  ),
                  AppSpacing.gapH10,
                  Expanded(
                    child: Text(
                      AppLocaleKey.registrationConfirmation.tr(),
                      style: AppTextStyles.xxxxsMedium.copyWith(
                        color: colors.formLabel,
                        height: _textHeight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
