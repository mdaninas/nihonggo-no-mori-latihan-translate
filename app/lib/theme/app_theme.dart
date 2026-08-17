import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const ink = Color(0xFF172033);
  static const muted = Color(0xFF667085);
  static const cream = Color(0xFFFFFCF7);
  static const paper = Color(0xFFFFFFFF);
  static const coral = Color(0xFFE36D58);
  static const sage = Color(0xFF3C806A);
  static const blue = Color(0xFF385E9D);
  static const gold = Color(0xFFC4843A);
  static const plum = Color(0xFF6B5B95);
  static const line = Color(0xFFE9E7E1);
  static const mist = Color(0xFFF4F1EA);

  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: coral,
      brightness: Brightness.light,
      surface: paper,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme.copyWith(primary: coral),
      scaffoldBackgroundColor: cream,
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          height: 1.15,
          fontWeight: FontWeight.w800,
          color: ink,
        ),
        headlineMedium: TextStyle(
          fontSize: 25,
          height: 1.2,
          fontWeight: FontWeight.w800,
          color: ink,
        ),
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: ink),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: ink),
        bodyLarge: TextStyle(fontSize: 16, height: 1.5, color: ink),
        bodyMedium: TextStyle(fontSize: 14, height: 1.45, color: muted),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: cream,
        foregroundColor: ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: paper,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: const BorderSide(color: line),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: coral,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ink,
          minimumSize: const Size.fromHeight(52),
          side: const BorderSide(color: line),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        ),
      ),
      chipTheme: ChipThemeData(
        selectedColor: const Color(0xFFFFE8E3),
        backgroundColor: paper,
        side: const BorderSide(color: line),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        labelStyle: const TextStyle(fontWeight: FontWeight.w700, color: ink),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: coral,
        linearTrackColor: line,
      ),
      dividerColor: line,
    );
  }
}
