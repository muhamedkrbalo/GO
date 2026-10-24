import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../../onboarding/presentation/view/widget/welcome_hero.dart';
import '../widget/login_sheet.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const _blurSigma = 5.0;
  static const _scrimOpacity = 0.62;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: colors.primary,
        body: Stack(
          fit: StackFit.expand,
          children: [
            ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: _blurSigma, sigmaY: _blurSigma),
              child: const Align(alignment: Alignment.topCenter, child: WelcomeHero()),
            ),
            ColoredBox(color: colors.imageScrim.withValues(alpha: _scrimOpacity)),
            const Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(child: LoginSheet()),
            ),
          ],
        ),
      ),
    );
  }
}
