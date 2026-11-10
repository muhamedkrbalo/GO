import 'package:flutter/material.dart';

import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class OwnerHomeSectionCard extends StatelessWidget {
  const OwnerHomeSectionCard({super.key, required this.child, this.gradient, this.borderColor});

  final Widget child;
  final Gradient? gradient;
  final Color? borderColor;

  static const _padding = EdgeInsetsDirectional.all(15);
  static const _radius = BorderRadius.all(Radius.circular(14));
  static const _borderWidth = 1.5;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: gradient == null ? colors.surface : null,
        gradient: gradient,
        borderRadius: _radius,
        border: Border.all(color: borderColor ?? colors.subtleBorder, width: _borderWidth),
        boxShadow: AppShadows.softCard,
      ),
      child: Padding(padding: _padding, child: child),
    );
  }
}
