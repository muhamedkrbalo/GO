import 'package:flutter/material.dart';

import '../../images/app_images.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  static const _width = 68.0;
  static const _height = 34.0;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImages.assetsImagesGoLogo,
      width: _width,
      height: _height,
      fit: BoxFit.fitWidth,
      alignment: Alignment.topCenter,
    );
  }
}
