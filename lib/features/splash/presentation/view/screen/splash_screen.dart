import 'package:flutter/material.dart';

import '../widget/splash_widget.dart';

/// Shown while [AuthSession] restores the stored session. Navigation away from
/// here is done by the router's redirect, not by this screen.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashWidget(),
    );
  }
}
