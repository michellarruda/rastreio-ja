// Rastreio Já — Presets de esquemas de cor completos
library;

// ignore_for_file: avoid_redundant_argument_values
import 'package:flutter/material.dart';
import 'package:rastreio_ja/core/constants/app_colors.dart';

enum AppColorPreset { vitality, ocean, sunset, minimal }

extension AppColorPresetExtension on AppColorPreset {
  String get displayName => switch (this) {
        AppColorPreset.vitality => 'Vitality',
        AppColorPreset.ocean => 'Ocean',
        AppColorPreset.sunset => 'Sunset',
        AppColorPreset.minimal => 'Minimal',
      };

  String get description => switch (this) {
        AppColorPreset.vitality => 'Verde-água vibrante',
        AppColorPreset.ocean => 'Azul oceano profundo',
        AppColorPreset.sunset => 'Laranja pôr do sol',
        AppColorPreset.minimal => 'Cinza elegante',
      };

  Color get previewColor => switch (this) {
        AppColorPreset.vitality => AppColors.tealPrimary,
        AppColorPreset.ocean => AppColors.oceanPrimary,
        AppColorPreset.sunset => AppColors.sunsetPrimary,
        AppColorPreset.minimal => AppColors.minimalPrimary,
      };
}

abstract final class ColorSchemePresets {
  // -------------------------------------------------------
  // Light schemes
  // -------------------------------------------------------
  static ColorScheme light(final AppColorPreset preset) => switch (preset) {
        AppColorPreset.vitality => _vitalityLight,
        AppColorPreset.ocean => _oceanLight,
        AppColorPreset.sunset => _sunsetLight,
        AppColorPreset.minimal => _minimalLight,
      };

  // -------------------------------------------------------
  // Dark schemes
  // -------------------------------------------------------
  static ColorScheme dark(final AppColorPreset preset) => switch (preset) {
        AppColorPreset.vitality => _vitalityDark,
        AppColorPreset.ocean => _oceanDark,
        AppColorPreset.sunset => _sunsetDark,
        AppColorPreset.minimal => _minimalDark,
      };

  // -------------------------------------------------------
  // Vitality (padrão — baseado no design anexo)
  // -------------------------------------------------------
  static const _vitalityLight = ColorScheme.light(
    primary: AppColors.tealPrimary,
    onPrimary: AppColors.textOnPrimary,
    primaryContainer: AppColors.tealSurface,
    onPrimaryContainer: AppColors.tealDark,
    secondary: AppColors.tealLight,
    onSecondary: AppColors.textOnPrimary,
    secondaryContainer: AppColors.tealSurface,
    onSecondaryContainer: AppColors.tealDark,
    tertiary: AppColors.accentYellow,
    onTertiary: AppColors.textOnPrimary,
    tertiaryContainer: AppColors.accentYellowLight,
    onTertiaryContainer: AppColors.textPrimaryLight,
    error: AppColors.error,
    onError: AppColors.textOnPrimary,
    errorContainer: AppColors.errorLight,
    onErrorContainer: AppColors.error,
    surface: AppColors.surfaceLight,
    onSurface: AppColors.textPrimaryLight,
    onSurfaceVariant: AppColors.textSecondaryLight,
    outline: AppColors.dividerLight,
    outlineVariant: AppColors.dividerLight,
    shadow: AppColors.shadowLight,
    scrim: AppColors.shadowLight,
    inverseSurface: AppColors.textPrimaryLight,
    onInverseSurface: AppColors.textOnPrimary,
    inversePrimary: AppColors.tealLight,
  );

  static const _vitalityDark = ColorScheme.dark(
    primary: AppColors.tealPrimary,
    onPrimary: AppColors.backgroundDark,
    primaryContainer: AppColors.tealDark,
    onPrimaryContainer: AppColors.tealSurface,
    secondary: AppColors.tealLight,
    onSecondary: AppColors.backgroundDark,
    secondaryContainer: AppColors.tealDark,
    onSecondaryContainer: AppColors.tealSurface,
    tertiary: AppColors.accentYellow,
    onTertiary: AppColors.backgroundDark,
    tertiaryContainer: AppColors.accentOrange,
    onTertiaryContainer: AppColors.textOnPrimary,
    error: AppColors.error,
    onError: AppColors.textOnPrimary,
    errorContainer: Color(0xFF8B0000),
    onErrorContainer: AppColors.errorLight,
    surface: AppColors.surfaceDark,
    onSurface: AppColors.textPrimaryDark,
    onSurfaceVariant: AppColors.textSecondaryDark,
    outline: AppColors.dividerDark,
    outlineVariant: AppColors.dividerDark,
    shadow: AppColors.shadowDark,
    scrim: AppColors.shadowDark,
    inverseSurface: AppColors.textPrimaryDark,
    onInverseSurface: AppColors.backgroundDark,
    inversePrimary: AppColors.tealDark,
  );

  // -------------------------------------------------------
  // Ocean
  // -------------------------------------------------------
  static const _oceanLight = ColorScheme.light(
    primary: AppColors.oceanPrimary,
    onPrimary: AppColors.textOnPrimary,
    primaryContainer: AppColors.oceanSurface,
    onPrimaryContainer: AppColors.oceanPrimary,
    secondary: AppColors.oceanSecondary,
    onSecondary: AppColors.textOnPrimary,
    secondaryContainer: AppColors.oceanSurface,
    onSecondaryContainer: AppColors.oceanPrimary,
    tertiary: AppColors.oceanTertiary,
    onTertiary: AppColors.textOnPrimary,
    tertiaryContainer: AppColors.oceanSurface,
    onTertiaryContainer: AppColors.oceanPrimary,
    error: AppColors.error,
    onError: AppColors.textOnPrimary,
    errorContainer: AppColors.errorLight,
    onErrorContainer: AppColors.error,
    surface: AppColors.surfaceLight,
    onSurface: AppColors.textPrimaryLight,
    onSurfaceVariant: AppColors.textSecondaryLight,
    outline: AppColors.dividerLight,
    outlineVariant: AppColors.dividerLight,
    shadow: AppColors.shadowLight,
    scrim: AppColors.shadowLight,
    inverseSurface: AppColors.textPrimaryLight,
    onInverseSurface: AppColors.textOnPrimary,
    inversePrimary: AppColors.oceanSecondary,
  );

  static const _oceanDark = ColorScheme.dark(
    primary: AppColors.oceanSecondary,
    onPrimary: AppColors.backgroundDark,
    primaryContainer: AppColors.oceanPrimary,
    onPrimaryContainer: AppColors.oceanSurface,
    secondary: AppColors.oceanTertiary,
    onSecondary: AppColors.backgroundDark,
    secondaryContainer: AppColors.oceanPrimary,
    onSecondaryContainer: AppColors.oceanSurface,
    tertiary: AppColors.oceanTertiary,
    onTertiary: AppColors.backgroundDark,
    tertiaryContainer: AppColors.oceanPrimary,
    onTertiaryContainer: AppColors.textOnPrimary,
    error: AppColors.error,
    onError: AppColors.textOnPrimary,
    errorContainer: Color(0xFF8B0000),
    onErrorContainer: AppColors.errorLight,
    surface: AppColors.surfaceDark,
    onSurface: AppColors.textPrimaryDark,
    onSurfaceVariant: AppColors.textSecondaryDark,
    outline: AppColors.dividerDark,
    outlineVariant: AppColors.dividerDark,
    shadow: AppColors.shadowDark,
    scrim: AppColors.shadowDark,
    inverseSurface: AppColors.textPrimaryDark,
    onInverseSurface: AppColors.backgroundDark,
    inversePrimary: AppColors.oceanPrimary,
  );

  // -------------------------------------------------------
  // Sunset
  // -------------------------------------------------------
  static const _sunsetLight = ColorScheme.light(
    primary: AppColors.sunsetPrimary,
    onPrimary: AppColors.textOnPrimary,
    primaryContainer: AppColors.sunsetSurface,
    onPrimaryContainer: AppColors.sunsetPrimary,
    secondary: AppColors.sunsetSecondary,
    onSecondary: AppColors.textOnPrimary,
    secondaryContainer: AppColors.sunsetSurface,
    onSecondaryContainer: AppColors.sunsetPrimary,
    tertiary: AppColors.sunsetTertiary,
    onTertiary: AppColors.textOnPrimary,
    tertiaryContainer: AppColors.sunsetSurface,
    onTertiaryContainer: AppColors.sunsetPrimary,
    error: AppColors.error,
    onError: AppColors.textOnPrimary,
    errorContainer: AppColors.errorLight,
    onErrorContainer: AppColors.error,
    surface: AppColors.surfaceLight,
    onSurface: AppColors.textPrimaryLight,
    onSurfaceVariant: AppColors.textSecondaryLight,
    outline: AppColors.dividerLight,
    outlineVariant: AppColors.dividerLight,
    shadow: AppColors.shadowLight,
    scrim: AppColors.shadowLight,
    inverseSurface: AppColors.textPrimaryLight,
    onInverseSurface: AppColors.textOnPrimary,
    inversePrimary: AppColors.sunsetSecondary,
  );

  static const _sunsetDark = ColorScheme.dark(
    primary: AppColors.sunsetPrimary,
    onPrimary: AppColors.backgroundDark,
    primaryContainer: Color(0xFF8B2500),
    onPrimaryContainer: AppColors.sunsetSurface,
    secondary: AppColors.sunsetSecondary,
    onSecondary: AppColors.backgroundDark,
    secondaryContainer: Color(0xFF7A4500),
    onSecondaryContainer: AppColors.sunsetSurface,
    tertiary: AppColors.sunsetTertiary,
    onTertiary: AppColors.backgroundDark,
    tertiaryContainer: Color(0xFF7A3500),
    onTertiaryContainer: AppColors.textOnPrimary,
    error: AppColors.error,
    onError: AppColors.textOnPrimary,
    errorContainer: Color(0xFF8B0000),
    onErrorContainer: AppColors.errorLight,
    surface: AppColors.surfaceDark,
    onSurface: AppColors.textPrimaryDark,
    onSurfaceVariant: AppColors.textSecondaryDark,
    outline: AppColors.dividerDark,
    outlineVariant: AppColors.dividerDark,
    shadow: AppColors.shadowDark,
    scrim: AppColors.shadowDark,
    inverseSurface: AppColors.textPrimaryDark,
    onInverseSurface: AppColors.backgroundDark,
    inversePrimary: Color(0xFFFFB4A0),
  );

  // -------------------------------------------------------
  // Minimal
  // -------------------------------------------------------
  static const _minimalLight = ColorScheme.light(
    primary: AppColors.minimalPrimary,
    onPrimary: AppColors.textOnPrimary,
    primaryContainer: AppColors.minimalSurface,
    onPrimaryContainer: AppColors.minimalPrimary,
    secondary: AppColors.minimalSecondary,
    onSecondary: AppColors.textOnPrimary,
    secondaryContainer: AppColors.minimalSurface,
    onSecondaryContainer: AppColors.minimalSecondary,
    tertiary: AppColors.minimalTertiary,
    onTertiary: AppColors.textOnPrimary,
    tertiaryContainer: AppColors.minimalSurface,
    onTertiaryContainer: AppColors.minimalTertiary,
    error: AppColors.error,
    onError: AppColors.textOnPrimary,
    errorContainer: AppColors.errorLight,
    onErrorContainer: AppColors.error,
    surface: AppColors.surfaceLight,
    onSurface: AppColors.textPrimaryLight,
    onSurfaceVariant: AppColors.textSecondaryLight,
    outline: AppColors.dividerLight,
    outlineVariant: AppColors.dividerLight,
    shadow: AppColors.shadowLight,
    scrim: AppColors.shadowLight,
    inverseSurface: AppColors.textPrimaryLight,
    onInverseSurface: AppColors.textOnPrimary,
    inversePrimary: AppColors.minimalSecondary,
  );

  static const _minimalDark = ColorScheme.dark(
    primary: Color(0xFFDFE6E9),
    onPrimary: AppColors.backgroundDark,
    primaryContainer: AppColors.minimalSecondary,
    onPrimaryContainer: AppColors.minimalSurface,
    secondary: AppColors.minimalSecondary,
    onSecondary: AppColors.backgroundDark,
    secondaryContainer: AppColors.minimalPrimary,
    onSecondaryContainer: AppColors.minimalSurface,
    tertiary: Color(0xFF74B9FF),
    onTertiary: AppColors.backgroundDark,
    tertiaryContainer: AppColors.minimalTertiary,
    onTertiaryContainer: AppColors.textOnPrimary,
    error: AppColors.error,
    onError: AppColors.textOnPrimary,
    errorContainer: Color(0xFF8B0000),
    onErrorContainer: AppColors.errorLight,
    surface: AppColors.surfaceDark,
    onSurface: AppColors.textPrimaryDark,
    onSurfaceVariant: AppColors.textSecondaryDark,
    outline: AppColors.dividerDark,
    outlineVariant: AppColors.dividerDark,
    shadow: AppColors.shadowDark,
    scrim: AppColors.shadowDark,
    inverseSurface: AppColors.textPrimaryDark,
    onInverseSurface: AppColors.backgroundDark,
    inversePrimary: AppColors.minimalSecondary,
  );
}
