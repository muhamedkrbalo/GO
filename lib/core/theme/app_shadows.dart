import 'package:flutter/material.dart';

class AppShadows {
  const AppShadows._();

  static const shadow1 = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 30,
    ),
  ];

  /// Soft brand-colored glow under primary buttons.
  static const primaryButton = [
    BoxShadow(
      color: Color(0x2E0F766E),
      offset: Offset(0, 10),
      blurRadius: 12,
    ),
  ];

  static const softCard = [
    BoxShadow(
      color: Color(0x0A0F172A),
      offset: Offset(0, 8),
      blurRadius: 12,
    ),
  ];

  static const bottomBar = [
    BoxShadow(
      color: Color(0x0D0F172A),
      offset: Offset(0, -8),
      blurRadius: 24,
    ),
  ];

  /// Large, soft shadow under hero images and cards.
  static const card = [
    BoxShadow(
      color: Color(0x170F172A),
      offset: Offset(0, 16),
      blurRadius: 32,
    ),
  ];
}
