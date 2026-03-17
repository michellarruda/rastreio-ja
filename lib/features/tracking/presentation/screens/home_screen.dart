// Rastreio Já — Tela principal (placeholder)
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rastreio_ja/core/router/app_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rastreio Já')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home — placeholder'),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => context.go(AppRoutes.settings),
              child: const Text('R'),
            ),
          ],
        ),
      ),
    );
  }
}
