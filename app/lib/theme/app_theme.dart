import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const ink = Color(0xFF1E293B);
  static const navy = Color(0xFF1E293B);
  static const muted = Color(0xFF64748B);
  static const cream = Color(0xFFF8FAFC);
  static const paper = Color(0xFFFFFFFF);
  static const coral = Color(0xFFFF6B6B);
  static const sage = Color(0xFF10B981);
  static const blue = Color(0xFF6366F1);
  static const gold = Color(0xFFD97706);
  static const plum = Color(0xFF7C6BA8);
  static const line = Color(0xFFE2E8F0);
  static const mist = Color(0xFFF1F5F9);

  static const _darkInk = Color(0xFFF1F5F9);
  static const _darkMuted = Color(0xFF94A3B8);
  static const _darkScaffold = Color(0xFF0F172A);
  static const _darkPaper = Color(0xFF1E293B);
  static const _darkLine = Color(0xFF334155);

  static ThemeData get light => _build(
        brightness: Brightness.light,
        scaffold: cream,
        surface: paper,
        onSurface: ink,
        mutedText: muted,
        outline: line,
        chipSelected: const Color(0xFFFFE4E4),
      );

  static ThemeData get dark => _build(
        brightness: Brightness.dark,
        scaffold: _darkScaffold,
        surface: _darkPaper,
        onSurface: _darkInk,
        mutedText: _darkMuted,
        outline: _darkLine,
        chipSelected: const Color(0xFF3D2525),
      );

  static ThemeData _build({
    required Brightness brightness,
    required Color scaffold,
    required Color surface,
    required Color onSurface,
    required Color mutedText,
    required Color outline,
    required Color chipSelected,
  }) {
    final scheme = ColorScheme.fromSeed(seedColor: coral, brightness: brightness).copyWith(
      primary: coral,
      surface: surface,
      onSurface: onSurface,
      outline: outline,
    );
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scaffold,
      textTheme: TextTheme(
        headlineLarge: TextStyle(fontSize: 32, height: 1.15, fontWeight: FontWeight.w800, color: onSurface),
        headlineMedium: TextStyle(fontSize: 25, height: 1.2, fontWeight: FontWeight.w800, color: onSurface),
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: onSurface),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: onSurface),
        bodyLarge: TextStyle(fontSize: 16, height: 1.5, color: onSurface),
        bodyMedium: TextStyle(fontSize: 14, height: 1.45, color: mutedText),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: scaffold,
        foregroundColor: onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: outline),
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
          foregroundColor: onSurface,
          minimumSize: const Size.fromHeight(52),
          side: BorderSide(color: outline),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        ),
      ),
      chipTheme: ChipThemeData(
        selectedColor: chipSelected,
        backgroundColor: surface,
        side: BorderSide(color: outline),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        labelStyle: TextStyle(fontWeight: FontWeight.w700, color: onSurface),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: coral, linearTrackColor: outline),
      dividerColor: outline,
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: navy,
        contentTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
