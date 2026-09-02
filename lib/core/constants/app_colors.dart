import 'package:flutter/material.dart';

class AppColors {
  // Primaries
  static const Color richBlack = Color(0xFF000000);
  static const Color surfaceBlack = Color(0xFF1A1A1A);

  // Gold Tones
  static const Color primaryGold = Color(0xFFD4AF37);
  static const Color secondaryGold = Color(0xFFFFD700);
  static const Color lightGold = Color(0xFFF9E79F);

  // UI Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFF8E8E93);
  static const Color glassBackground = Color(0x1AFFFFFF);

  // Gradients
  static const LinearGradient goldGradient = LinearGradient(
    colors: [primaryGold, secondaryGold],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
