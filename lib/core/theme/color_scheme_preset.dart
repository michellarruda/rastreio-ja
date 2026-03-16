// Rastreio Já — Presets de esquemas de cor
library;

import 'package:flutter/material.dart';

enum AppColorPreset { vitality, ocean, sunset, minimal }

class ColorSchemePresets {
  static ColorScheme light(final AppColorPreset preset) {
    return switch (preset) {
      AppColorPreset.vitality => const ColorScheme.light(
          primary: Color(0xFF2ECFCF),
          secondary: Color(0xFF4ADEDE),
          tertiary: Color(0xFFF5A623),
        ),
      AppColorPreset.ocean => const ColorScheme.light(
          primary: Color(0xFF1A73E8),
          secondary: Color(0xFF4FC3F7),
          tertiary: Color(0xFF00BCD4),
        ),
      AppColorPreset.sunset => const ColorScheme.light(
          primary: Color(0xFFFF6B6B),
          secondary: Color(0xFFFFB347),
          tertiary: Color(0xFFFF8E53),
        ),
      AppColorPreset.minimal => const ColorScheme.light(
          primary: Color(0xFF2D3436),
          secondary: Color(0xFF636E72),
          tertiary: Color(0xFF0984E3),
        ),
    };
  }

  static ColorScheme dark(final AppColorPreset preset) {
    return switch (preset) {
      AppColorPreset.vitality => const ColorScheme.dark(
          primary: Color(0xFF2ECFCF),
          secondary: Color(0xFF4ADEDE),
          tertiary: Color(0xFFF5A623),
        ),
      AppColorPreset.ocean => const ColorScheme.dark(
          primary: Color(0xFF4FC3F7),
          secondary: Color(0xFF1A73E8),
          tertiary: Color(0xFF00BCD4),
        ),
      AppColorPreset.sunset => const ColorScheme.dark(
          primary: Color(0xFFFF6B6B),
          secondary: Color(0xFFFFB347),
          tertiary: Color(0xFFFF8E53),
        ),
      AppColorPreset.minimal => const ColorScheme.dark(
          primary: Color(0xFFDFE6E9),
          secondary: Color(0xFFB2BEC3),
          tertiary: Color(0xFF74B9FF),
        ),
    };
  }
}
