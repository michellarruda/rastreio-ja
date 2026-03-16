// Rastreio Já — Root Widget
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rastreio_ja/core/router/app_router.dart';
import 'package:rastreio_ja/core/theme/app_theme.dart';
import 'package:rastreio_ja/core/theme/color_scheme_preset.dart';
import 'package:rastreio_ja/core/theme/theme_notifier.dart';

class RastreioJaApp extends ConsumerWidget {
  const RastreioJaApp({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    return MaterialApp.router(
      title:                      'Rastreio Já',
      debugShowCheckedModeBanner: false,
      routerConfig:               appRouter,
      themeMode:                  themeState.mode,
      theme:     AppTheme.light(ColorSchemePresets.light(themeState.preset)),
      darkTheme: AppTheme.dark(ColorSchemePresets.dark(themeState.preset)),
    );
  }
}
