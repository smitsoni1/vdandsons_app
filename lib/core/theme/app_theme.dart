import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.richBlack,
      primaryColor: AppColors.primaryGold,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryGold,
        secondary: AppColors.secondaryGold,
        surface: AppColors.surfaceBlack,
        onPrimary: AppColors.richBlack,
        onSurface: AppColors.white,
      ),
      textTheme: GoogleFonts.montserratTextTheme(
        ThemeData.dark().textTheme,
      ).copyWith(
        displayLarge: GoogleFonts.playfairDisplay(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: GoogleFonts.playfairDisplay(
          color: AppColors.primaryGold,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: GoogleFonts.playfairDisplay(
          color: AppColors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.richBlack,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.playfairDisplay(
          color: AppColors.primaryGold,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
