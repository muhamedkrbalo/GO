import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/app_logo/app_logo.dart';
import 'account_verified_badge.dart';

class BusinessRoleHeader extends StatelessWidget {
  const BusinessRoleHeader({super.key});

  static const _height = 56.0;

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: _height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [AppLogo(), AccountVerifiedBadge()],
      ),
    );
  }
}
