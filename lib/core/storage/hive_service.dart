// Rastreio Já — Inicialização do Hive
library;

import 'package:hive_flutter/hive_flutter.dart';
import 'package:rastreio_ja/core/constants/app_constants.dart';
import 'package:rastreio_ja/features/tracking/data/models/package_model.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();

    // Registrar adapters gerados pelo build_runner
    if (!Hive.isAdapterRegistered(PackageModelAdapter().typeId)) {
      Hive.registerAdapter(PackageModelAdapter());
    }

    await Hive.openBox<PackageModel>(AppConstants.packagesBoxName);
    await Hive.openBox<dynamic>(AppConstants.settingsBoxName);
  }
}
