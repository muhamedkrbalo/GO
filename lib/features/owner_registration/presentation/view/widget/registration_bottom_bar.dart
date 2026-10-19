import 'package:flutter/material.dart';

import '../../../../../core/theme/app_shadows.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class RegistrationBottomBar extends StatelessWidget {
  const RegistrationBottomBar({super.key, required this.children});

  final List<Widget> children;

  static const _padding = EdgeInsets.fromLTRB(20, 14, 20, 12);
  static const _borderWidth = 1.6;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(
          top: BorderSide(color: colors.subtleBorder, width: _borderWidth),
        ),
        boxShadow: AppShadows.bottomBar,
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: _padding,
          child: Column(mainAxisSize: MainAxisSize.min, children: children),
        ),
      ),
    );
  }
}
