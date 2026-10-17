import 'package:flutter/material.dart';
import 'package:flutter_hr_erb/core/theme/app_sizes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../images/app_images.dart';
import '../../locale/app_locale_key.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_hr_erb/core/theme/app_colors.dart';
import 'package:flutter_hr_erb/core/theme/extensions/theme_extensions.dart';

class ChooseGalleryOrCameraBottomSheet extends StatelessWidget {
  final void Function()? onCamera;
  final void Function()? onGallery;
  const ChooseGalleryOrCameraBottomSheet({
    super.key,
    this.onCamera,
    this.onGallery,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.customColors.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppSpacing.gapV15,
          SizedBox(
            width: 40,
            child: Divider(color: context.customColors.hint),
          ),
          AppSpacing.gapV15,
          Flexible(
            child: SingleChildScrollView(
              padding: AppPadding.h20,
              child: Column(
                children: [
                  TextButton(
                    onPressed: onCamera,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppImages.assetsGlobalIconCamera,
                          colorFilter:  ColorFilter.mode(
                            Theme.of(context).primaryColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        AppSpacing.gapH10,
                        Text(
                          AppLocaleKey.camera.tr(),
                          style:  TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: context.customColors.hint,
                  ),
                  TextButton(
                    onPressed: onGallery,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppImages.assetsGlobalIconGallery,
                          colorFilter: const ColorFilter.mode(
                            AppColors.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                        AppSpacing.gapH10,
                        Text(
                          tr(AppLocaleKey.gallery),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.gapV15,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
