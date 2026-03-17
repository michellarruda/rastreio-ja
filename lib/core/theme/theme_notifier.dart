// Rastreio Já — Notifier do tema com persistência
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rastreio_ja/core/constants/app_constants.dart';
import 'package:rastreio_ja/core/theme/color_scheme_preset.dart';
import 'package:shared_preferences/shared_preferences.dart';

// -------------------------------------------------------
// State
// -------------------------------------------------------
class ThemeState {
  const ThemeState({
    this.mode = ThemeMode.system,
    this.preset = AppColorPreset.vitality,
  });

  final ThemeMode mode;
  final AppColorPreset preset;

  ThemeState copyWith({
    final ThemeMode? mode,
    final AppColorPreset? preset,
  }) =>
      ThemeState(
        mode: mode ?? this.mode,
        preset: preset ?? this.preset,
      );
}

// -------------------------------------------------------
// Notifier
// -------------------------------------------------------
class ThemeNotifier extends AsyncNotifier<ThemeState> {
  @override
  Future<ThemeState> build() async {
    final prefs = await SharedPreferences.getInstance();

    final modeIndex = prefs.getInt(AppConstants.prefThemeMode) ?? 0;
    final presetIndex = prefs.getInt(AppConstants.prefColorPreset) ?? 0;

    return ThemeState(
      mode: ThemeMode.values[modeIndex.clamp(0, ThemeMode.values.length - 1)],
      preset: AppColorPreset
          .values[presetIndex.clamp(0, AppColorPreset.values.length - 1)],
    );
  }

  Future<void> setMode(final ThemeMode mode) async {
    final current = state.valueOrNull ?? const ThemeState();
    state = AsyncData(current.copyWith(mode: mode));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(AppConstants.prefThemeMode, mode.index);
  }

  Future<void> setPreset(final AppColorPreset preset) async {
    final current = state.valueOrNull ?? const ThemeState();
    state = AsyncData(current.copyWith(preset: preset));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(AppConstants.prefColorPreset, preset.index);
  }
}

// -------------------------------------------------------
// Provider
// -------------------------------------------------------
final themeProvider =
    AsyncNotifierProvider<ThemeNotifier, ThemeState>(ThemeNotifier.new);
