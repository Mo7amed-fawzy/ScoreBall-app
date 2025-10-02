import 'package:flutter/material.dart';

abstract class AppTheme {
  static const MaterialColor _lightPrimary = Colors.orange;

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _lightPrimary,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      primarySwatch: _lightPrimary,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 2,
        centerTitle: true,
      ),
      cardColor: colorScheme.surface,
      dividerColor: colorScheme.outline.withValues(alpha: 0.12),
      textTheme: Typography.material2021(platform: TargetPlatform.android)
          .black
          .apply(bodyColor: colorScheme.onSurface),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          minimumSize: const Size(64, 48),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
        hintStyle:
            TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.6)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: colorScheme.primary.withValues(alpha: 0.6)),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.all(colorScheme.primary),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(colorScheme.primary),
        trackColor:
            WidgetStateProperty.all(colorScheme.primary.withValues(alpha: 0.4)),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.all(colorScheme.primary),
      ),
      iconTheme: IconThemeData(color: colorScheme.onSurface),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.secondary,
        foregroundColor: colorScheme.onSecondary,
      ),
      dialogTheme: DialogThemeData(backgroundColor: colorScheme.surface),
    );
  }

  static ThemeData get darkTheme {
    const background = Color(0xFF131A24);
    const appBarBg = Color(0xFF0F151C);
    const cardBg = Color(0xFF1F252F);
    const primaryBlue = Colors.blueAccent;

    const colorScheme = ColorScheme.dark(
      primary: primaryBlue,
      secondary: primaryBlue,
      surface: background,
      surfaceContainerHighest: appBarBg,
      surfaceContainer: cardBg,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      outline: Colors.white70,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      appBarTheme: const AppBarTheme(
        backgroundColor: appBarBg,
        foregroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),
      cardColor: cardBg,
      dividerColor: Colors.white24,
      textTheme: Typography.material2021(platform: TargetPlatform.android)
          .white
          .apply(bodyColor: Colors.white),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          minimumSize: const Size(64, 48),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white10,
        hintStyle: const TextStyle(color: Colors.white54),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white24),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.all(primaryBlue),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(primaryBlue),
        trackColor: WidgetStateProperty.all(primaryBlue.withOpacity(0.4)),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.all(primaryBlue),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
      ),
      dialogTheme: DialogThemeData(backgroundColor: background),
    );
  }
}
