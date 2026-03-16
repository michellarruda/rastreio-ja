// Rastreio Já — Entry point
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rastreio_ja/app.dart';
import 'package:rastreio_ja/core/storage/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  runApp(
    const ProviderScope(
      child: RastreioJaApp(),
    ),
  );
}
