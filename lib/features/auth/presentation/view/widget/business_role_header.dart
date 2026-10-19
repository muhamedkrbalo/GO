

import 'package:flutter/material.dart';
import 'package:flutter_hr_erb/core/images/app_images.dart';
import 'package:flutter_hr_erb/features/auth/presentation/view/widget/account_verified_badge.dart';

class BusinessRoleHeader extends StatelessWidget {
  const BusinessRoleHeader({super.key});

  static const _height = 56.0;
  static const _logoWidth = 68.0;
  static const _logoHeight = 34.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            AppImages.assetsImagesGoLogo,
            width: _logoWidth,
            height: _logoHeight,
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
          const AccountVerifiedBadge(),
        ],
      ),
    );
  }
}
