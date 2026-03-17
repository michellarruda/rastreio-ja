// Rastreio Já — Entry point
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:rastreio_ja/app.dart';
import 'package:rastreio_ja/core/services/notification_service.dart';
import 'package:rastreio_ja/core/storage/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  await HiveService.init();
  await NotificationService.instance.init();
  runApp(
    const ProviderScope(
      child: RastreioJaApp(),
    ),
  );
}
