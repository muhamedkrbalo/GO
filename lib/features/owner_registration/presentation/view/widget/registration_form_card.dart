import 'package:flutter/material.dart';

import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class RegistrationFormCard extends StatelessWidget {
  const RegistrationFormCard({super.key, required this.children});

  final List<Widget> children;

  static const _radius = BorderRadius.all(Radius.circular(14.4));
  static const _borderWidth = 1.6;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: _radius,
        border: Border.all(color: colors.subtleBorder, width: _borderWidth),
        boxShadow: AppShadows.softCard,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: children),
    );
  }
}
