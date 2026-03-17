// Rastreio Já — ThemeData completo (light + dark)
library;

// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rastreio_ja/core/constants/app_colors.dart';

class AppTheme {
  const AppTheme._();

  // -------------------------------------------------------
  // Light Theme
  // -------------------------------------------------------
  static ThemeData light(final ColorScheme scheme) => ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        scaffoldBackgroundColor: AppColors.backgroundLight,

        // AppBar
        appBarTheme: AppBarTheme(
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
          backgroundColor: AppColors.backgroundLight,
          foregroundColor: AppColors.textPrimaryLight,
          titleTextStyle: const TextStyle(
            color: AppColors.textPrimaryLight,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          iconTheme: const IconThemeData(
            color: AppColors.textPrimaryLight,
          ),
        ),

        // Card
        cardTheme: CardThemeData(
          elevation: 0,
          color: AppColors.cardLight,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(
              color: AppColors.dividerLight,
            ),
          ),
          margin: EdgeInsets.zero,
        ),

        // Input
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surfaceLight2,
          border: _inputBorder(),
          enabledBorder: _inputBorder(),
          focusedBorder: _inputBorder(
            color: AppColors.tealPrimary,
            width: 2,
          ),
          errorBorder: _inputBorder(color: AppColors.error),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          hintStyle: const TextStyle(
            color: AppColors.textDisabledLight,
            fontSize: 14,
          ),
          labelStyle: const TextStyle(
            color: AppColors.textSecondaryLight,
            fontSize: 14,
          ),
        ),

        // FilledButton
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.tealPrimary,
            foregroundColor: AppColors.textOnPrimary,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ),

        // OutlinedButton
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.tealPrimary,
            minimumSize: const Size(double.infinity, 52),
            side: const BorderSide(color: AppColors.tealPrimary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // TextButton
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.tealPrimary,
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // FloatingActionButton
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.tealPrimary,
          foregroundColor: AppColors.textOnPrimary,
          elevation: 4,
          shape: CircleBorder(),
        ),

        // BottomNavigationBar
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.surfaceLight,
          selectedItemColor: AppColors.tealPrimary,
          unselectedItemColor: AppColors.textSecondaryLight,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12,
          ),
        ),

        // NavigationRail (Web/Desktop)
        navigationRailTheme: const NavigationRailThemeData(
          backgroundColor: AppColors.surfaceLight,
          selectedIconTheme: IconThemeData(color: AppColors.tealPrimary),
          unselectedIconTheme:
              IconThemeData(color: AppColors.textSecondaryLight),
          selectedLabelTextStyle: TextStyle(
            color: AppColors.tealPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelTextStyle: TextStyle(
            color: AppColors.textSecondaryLight,
            fontSize: 12,
          ),
          indicatorColor: AppColors.tealSurface,
        ),

        // Chip
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.surfaceLight2,
          selectedColor: AppColors.tealSurface,
          labelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        ),

        // Divider
        dividerTheme: const DividerThemeData(
          color: AppColors.dividerLight,
          thickness: 1,
          space: 1,
        ),

        // ListTile
        listTileTheme: const ListTileThemeData(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          titleTextStyle: TextStyle(
            color: AppColors.textPrimaryLight,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          subtitleTextStyle: TextStyle(
            color: AppColors.textSecondaryLight,
            fontSize: 13,
          ),
        ),

        // Snackbar
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.textPrimaryLight,
          contentTextStyle: const TextStyle(
            color: AppColors.textOnPrimary,
            fontSize: 14,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          behavior: SnackBarBehavior.floating,
        ),

        // Switch
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith(
            (final states) => states.contains(WidgetState.selected)
                ? AppColors.tealPrimary
                : AppColors.textDisabledLight,
          ),
          trackColor: WidgetStateProperty.resolveWith(
            (final states) => states.contains(WidgetState.selected)
                ? AppColors.tealSurface
                : AppColors.dividerLight,
          ),
        ),

        // Text
        textTheme: _textTheme(AppColors.textPrimaryLight),
      );

  // -------------------------------------------------------
  // Dark Theme
  // -------------------------------------------------------
  static ThemeData dark(final ColorScheme scheme) => ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        scaffoldBackgroundColor: AppColors.backgroundDark,
        appBarTheme: AppBarTheme(
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
          backgroundColor: AppColors.backgroundDark,
          foregroundColor: AppColors.textPrimaryDark,
          titleTextStyle: const TextStyle(
            color: AppColors.textPrimaryDark,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
          systemOverlayStyle: SystemUiOverlayStyle.light,
          iconTheme: const IconThemeData(
            color: AppColors.textPrimaryDark,
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          color: AppColors.cardDark,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(
              color: AppColors.dividerDark,
            ),
          ),
          margin: EdgeInsets.zero,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surfaceDark2,
          border: _inputBorder(color: AppColors.dividerDark),
          enabledBorder: _inputBorder(color: AppColors.dividerDark),
          focusedBorder: _inputBorder(
            color: AppColors.tealPrimary,
            width: 2,
          ),
          errorBorder: _inputBorder(color: AppColors.error),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          hintStyle: const TextStyle(
            color: AppColors.textDisabledDark,
            fontSize: 14,
          ),
          labelStyle: const TextStyle(
            color: AppColors.textSecondaryDark,
            fontSize: 14,
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.tealPrimary,
            foregroundColor: AppColors.textOnPrimary,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.tealPrimary,
            minimumSize: const Size(double.infinity, 52),
            side: const BorderSide(color: AppColors.tealPrimary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.tealPrimary,
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.tealPrimary,
          foregroundColor: AppColors.textOnPrimary,
          elevation: 4,
          shape: CircleBorder(),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.surfaceDark,
          selectedItemColor: AppColors.tealPrimary,
          unselectedItemColor: AppColors.textSecondaryDark,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(fontSize: 12),
        ),
        navigationRailTheme: const NavigationRailThemeData(
          backgroundColor: AppColors.surfaceDark,
          selectedIconTheme: IconThemeData(color: AppColors.tealPrimary),
          unselectedIconTheme:
              IconThemeData(color: AppColors.textSecondaryDark),
          selectedLabelTextStyle: TextStyle(
            color: AppColors.tealPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelTextStyle: TextStyle(
            color: AppColors.textSecondaryDark,
            fontSize: 12,
          ),
          indicatorColor: AppColors.surfaceDark3,
        ),
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.surfaceDark2,
          selectedColor: AppColors.surfaceDark3,
          labelStyle: const TextStyle(
            color: AppColors.textPrimaryDark,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.dividerDark,
          thickness: 1,
          space: 1,
        ),
        listTileTheme: const ListTileThemeData(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          titleTextStyle: TextStyle(
            color: AppColors.textPrimaryDark,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          subtitleTextStyle: TextStyle(
            color: AppColors.textSecondaryDark,
            fontSize: 13,
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.surfaceDark2,
          contentTextStyle: const TextStyle(
            color: AppColors.textPrimaryDark,
            fontSize: 14,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          behavior: SnackBarBehavior.floating,
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith(
            (final states) => states.contains(WidgetState.selected)
                ? AppColors.tealPrimary
                : AppColors.textDisabledDark,
          ),
          trackColor: WidgetStateProperty.resolveWith(
            (final states) => states.contains(WidgetState.selected)
                ? AppColors.surfaceDark3
                : AppColors.dividerDark,
          ),
        ),
        textTheme: _textTheme(AppColors.textPrimaryDark),
      );

  // -------------------------------------------------------
  // Helpers privados
  // -------------------------------------------------------
  static OutlineInputBorder _inputBorder({
    final Color color = AppColors.dividerLight,
    final double width = 1,
  }) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color, width: width),
      );

  static TextTheme _textTheme(final Color primary) => TextTheme(
        displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.w700,
          color: primary,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w700,
          color: primary,
          letterSpacing: -0.3,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w600,
          color: primary,
        ),
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: primary,
          letterSpacing: -0.3,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: primary,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: primary,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: primary,
          letterSpacing: -0.2,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: primary,
          letterSpacing: 0.1,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: primary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: primary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: primary,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: primary,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: primary,
          letterSpacing: 0.1,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: primary,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: primary,
          letterSpacing: 0.3,
        ),
      );
}
