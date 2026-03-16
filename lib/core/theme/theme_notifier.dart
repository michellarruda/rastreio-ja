// Rastreio Já — Notifier do tema
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rastreio_ja/core/theme/color_scheme_preset.dart';

class ThemeState {
  const ThemeState({
    this.mode   = ThemeMode.system,
    this.preset = AppColorPreset.vitality,
  });

  final ThemeMode      mode;
  final AppColorPreset preset;

  ThemeState copyWith({
    final ThemeMode? mode,
    final AppColorPreset? preset,
  }) =>
      ThemeState(
        mode:   mode   ?? this.mode,
        preset: preset ?? this.preset,
      );
}

class ThemeNotifier extends Notifier<ThemeState> {
  @override
  ThemeState build() => const ThemeState();

  void setMode(final ThemeMode mode) =>
      state = state.copyWith(mode: mode);

  void setPreset(final AppColorPreset preset) =>
      state = state.copyWith(preset: preset);
}

final themeProvider =
    NotifierProvider<ThemeNotifier, ThemeState>(ThemeNotifier.new);
