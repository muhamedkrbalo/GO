import 'package:flutter/material.dart';
import 'package:flutter_hr_erb/core/theme/app_sizes.dart';
import 'package:flutter_svg/svg.dart';
import '../../extension/context_extension.dart';
import '../../images/app_images.dart';
import 'package:flutter_hr_erb/core/theme/extensions/theme_extensions.dart';

class NoDataWidget extends StatelessWidget {
  final Axis axis;
  final String? message;
  const NoDataWidget({
    super.key,
    this.axis = Axis.vertical,
    this.message,
  });
  @override
  Widget build(BuildContext context) {
    switch (axis) {
      case Axis.horizontal:
        return Container(
          padding: AppPadding.v5h10,
          decoration: const BoxDecoration(
            //     color: AppColors.primary.withOpacity(0),
            borderRadius: AppRadius.brS,
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                SvgPicture.asset(
                  AppImages.assetsGlobalIconEmptyFolderIcon,
                  colorFilter: ColorFilter.mode(
                    context.customColors.onBackground,
                    BlendMode.srcIn,
                  ),
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                ),
                AppSpacing.gapH10,
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      message ??
                          context.apiTr(
                            ar: "لا توجد بيانات",
                            en: "There is no data",
                          ),
                      style: TextStyle(
                        color: context.customColors.onBackground,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      case Axis.vertical:
        return Container(
          width: double.infinity,
          padding: AppPadding.v20h10,
          decoration: const BoxDecoration(
            //   color: AppColors.primary.withOpacity(0.2),
            borderRadius: AppRadius.brS,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                AppImages.assetsGlobalIconEmptyFolderIcon,
                colorFilter: ColorFilter.mode(
                  context.customColors.onBackground,
                  BlendMode.srcIn,
                ),
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
              AppSpacing.gapV10,
              Text(
                message ??
                    context.apiTr(
                      ar: "لا توجد بيانات",
                      en: "There is no data",
                    ),
                style: TextStyle(
                  color: context.customColors.onBackground,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
    }
  }
}
