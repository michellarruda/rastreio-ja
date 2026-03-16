// Rastreio Já — Tela detalhes (placeholder)
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PackageDetailScreen extends ConsumerWidget {
  const PackageDetailScreen({required this.packageId, super.key});
  final String packageId;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    return Scaffold(
      body: Center(child: Text('Pacote: $packageId')),
    );
  }
}
