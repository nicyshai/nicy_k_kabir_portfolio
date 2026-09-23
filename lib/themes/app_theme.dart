import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Flutter-brand-inspired palette: deep space background with a
/// blue -> cyan signature gradient (distinct from the reference design's
/// orange/purple treatment), plus a warm amber accent for contrast.
class AppColors {
  AppColors._();

  // Brand gradient
  static const Color brandBlue = Color(0xFF0468D7);
  static const Color brandCyan = Color(0xFF13B9FD);
  static const Color accentAmber = Color(0xFFFFA53C);

  // Dark theme surfaces
  static const Color darkBg = Color(0xFF0B0F17);
  static const Color darkSurface = Color(0xFF121826);
  static const Color darkSurfaceAlt = Color(0xFF171F2E);
  static const Color darkBorder = Color(0xFF232C3D);
  static const Color darkTextPrimary = Color(0xFFF2F5FA);
  static const Color darkTextSecondary = Color(0xFF9AA5B4);

  // Light theme surfaces
  static const Color lightBg = Color(0xFFF7F9FC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceAlt = Color(0xFFEFF3F9);
  static const Color lightBorder = Color(0xFFE1E7F0);
  static const Color lightTextPrimary = Color(0xFF10141C);
  static const Color lightTextSecondary = Color(0xFF5B6472);

  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [brandBlue, brandCyan],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [brandCyan, accentAmber],
  );
}

class AppTheme {
  AppTheme._();

  static TextTheme _textTheme(Color primary, Color secondary) {
    final base = GoogleFonts.plusJakartaSansTextTheme();
    return base.copyWith(
      displayLarge: GoogleFonts.plusJakartaSans(
        fontSize: 56, fontWeight: FontWeight.w800, color: primary, height: 1.1),
      displayMedium: GoogleFonts.plusJakartaSans(
        fontSize: 40, fontWeight: FontWeight.w800, color: primary, height: 1.15),
      headlineMedium: GoogleFonts.plusJakartaSans(
        fontSize: 30, fontWeight: FontWeight.w700, color: primary),
      titleLarge: GoogleFonts.plusJakartaSans(
        fontSize: 20, fontWeight: FontWeight.w700, color: primary),
      titleMedium: GoogleFonts.plusJakartaSans(
        fontSize: 16, fontWeight: FontWeight.w600, color: primary),
      bodyLarge: GoogleFonts.inter(
        fontSize: 17, fontWeight: FontWeight.w400, color: secondary, height: 1.6),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14, fontWeight: FontWeight.w400, color: secondary, height: 1.6),
      labelLarge: GoogleFonts.inter(
        fontSize: 14, fontWeight: FontWeight.w600, color: primary),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'sans-serif',
      fontFamilyFallback: const ['Roboto', 'Arial', 'sans-serif'],
      scaffoldBackgroundColor: AppColors.darkBg,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.brandCyan,
        secondary: AppColors.accentAmber,
        surface: AppColors.darkSurface,
      ),
      textTheme: _textTheme(AppColors.darkTextPrimary, AppColors.darkTextSecondary),
      dividerColor: AppColors.darkBorder,
      splashFactory: InkRipple.splashFactory,
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'sans-serif',
      fontFamilyFallback: const ['Roboto', 'Arial', 'sans-serif'],
      scaffoldBackgroundColor: AppColors.lightBg,
      colorScheme: const ColorScheme.light(
        primary: AppColors.brandBlue,
        secondary: AppColors.accentAmber,
        surface: AppColors.lightSurface,
      ),
      textTheme: _textTheme(AppColors.lightTextPrimary, AppColors.lightTextSecondary),
      dividerColor: AppColors.lightBorder,
      splashFactory: InkRipple.splashFactory,
    );
  }
}
