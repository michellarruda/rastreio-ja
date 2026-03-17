// Rastreio Já — Teste: ColorSchemePresets
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:rastreio_ja/core/theme/color_scheme_preset.dart';
import 'package:flutter/material.dart';

void main() {
  group('ColorSchemePresets', () {
    test('deve retornar ColorScheme light para cada preset', () {
      for (final preset in AppColorPreset.values) {
        final scheme = ColorSchemePresets.light(preset);
        expect(scheme.brightness.name, equals('light'));
      }
    });

    test('deve retornar ColorScheme dark para cada preset', () {
      for (final preset in AppColorPreset.values) {
        final scheme = ColorSchemePresets.dark(preset);
        expect(scheme.brightness.name, equals('dark'));
      }
    });

    test('Vitality preset deve ter cor primária teal', () {
      final scheme = ColorSchemePresets.light(AppColorPreset.vitality);
      expect(scheme.primary.value, equals(const Color(0xFF2ECFCF).value));
    });
  });
}
