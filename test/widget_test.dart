import 'package:flutter/material.dart';
import 'package:flutter_hr_erb/features/splash/presentation/view/screen/splash_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('SplashScreen renders', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SplashScreen()));

    expect(find.text('Splash Screen'), findsOneWidget);
  });
}
