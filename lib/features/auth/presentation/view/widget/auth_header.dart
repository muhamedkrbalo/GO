import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/app_logo/app_logo.dart';
import '../../../../../core/custom_widgets/buttons/app_back_button.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  static const _height = 56.0;
  static const _sideSlot = 44.0;

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: _height,
      child: Row(
        children: [
          AppBackButton(),
          Expanded(child: Center(child: AppLogo())),
          SizedBox.square(dimension: _sideSlot),
        ],
      ),
    );
  }
}
