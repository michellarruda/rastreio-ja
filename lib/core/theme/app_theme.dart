// Rastreio Já — ThemeData principal
library;

import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light(final ColorScheme scheme) => ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
      );

  static ThemeData dark(final ColorScheme scheme) => ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
      );
}
