import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});


  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return SizedBox(
      height: 56.0,
      child: Row(
        children: [
          Material(
            color: colors.surface,
            shape: RoundedRectangleBorder(
              borderRadius:const  BorderRadius.all(Radius.circular(12.8)),
              side: BorderSide(color: colors.subtleBorder, width: 1.6),
            ),
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(12.8)),
              onTap: context.pop,
              child: SizedBox.square(
                dimension: 44.0,
                child: Center(
                  child: SvgPicture.asset(
                    AppImages.assetsSvgArrowBack,
                    matchTextDirection: true,
                    colorFilter: ColorFilter.mode(colors.textSecondary, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Image.asset(
                AppImages.assetsImagesGoLogo,
                width: 68.0,
                height: 34.0,
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          const SizedBox.square(dimension: 44.0),
        ],
      ),
    );
  }
}
