// Rastreio Já — Tela principal (placeholder)
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    return const Scaffold(
      body: Center(child: Text('Rastreio Já — Home')),
    );
  }
}
