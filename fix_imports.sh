#!/bin/bash
set -e

mf() {
  mkdir -p "$(dirname "$1")"
  printf '%s' "$2" > "$1"
  echo "  [FIX] $1"
}

echo ""
echo "Rastreio Já — Corrigindo imports e warnings..."
echo ""

mf "lib/app.dart" \
'// Rastreio Já — Root Widget
library;

import '"'"'package:flutter/material.dart'"'"';
import '"'"'package:flutter_riverpod/flutter_riverpod.dart'"'"';
import '"'"'package:rastreio_ja/core/router/app_router.dart'"'"';
import '"'"'package:rastreio_ja/core/theme/app_theme.dart'"'"';
import '"'"'package:rastreio_ja/core/theme/color_scheme_preset.dart'"'"';
import '"'"'package:rastreio_ja/core/theme/theme_notifier.dart'"'"';

class RastreioJaApp extends ConsumerWidget {
  const RastreioJaApp({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    return MaterialApp.router(
      title:                      '"'"'Rastreio Já'"'"',
      debugShowCheckedModeBanner: false,
      routerConfig:               appRouter,
      themeMode:                  themeState.mode,
      theme:     AppTheme.light(ColorSchemePresets.light(themeState.preset)),
      darkTheme: AppTheme.dark(ColorSchemePresets.dark(themeState.preset)),
    );
  }
}
'

mf "lib/main.dart" \
'// Rastreio Já — Entry point
import '"'"'package:flutter/material.dart'"'"';
import '"'"'package:flutter_riverpod/flutter_riverpod.dart'"'"';
import '"'"'package:rastreio_ja/app.dart'"'"';
import '"'"'package:rastreio_ja/core/storage/hive_service.dart'"'"';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  runApp(
    const ProviderScope(
      child: RastreioJaApp(),
    ),
  );
}
'

mf "lib/core/network/dio_client.dart" \
'// Rastreio Já — Cliente HTTP (Dio)
library;

import '"'"'package:dio/dio.dart'"'"';
import '"'"'package:rastreio_ja/core/constants/app_constants.dart'"'"';

Dio createDioClient() {
  final dio = Dio(
    const BaseOptions(
      baseUrl:        AppConstants.apiBaseUrl,
      connectTimeout: Duration(milliseconds: AppConstants.apiTimeout),
      receiveTimeout: Duration(milliseconds: AppConstants.apiTimeout),
      headers: {'"'"'Content-Type'"'"': '"'"'application/json'"'"'},
    ),
  );
  return dio;
}
'

mf "lib/core/router/app_router.dart" \
'// Rastreio Já — Rotas (GoRouter)
library;

import '"'"'package:flutter/material.dart'"'"';
import '"'"'package:go_router/go_router.dart'"'"';
import '"'"'package:rastreio_ja/features/tracking/presentation/screens/home_screen.dart'"'"';
import '"'"'package:rastreio_ja/features/tracking/presentation/screens/add_package_screen.dart'"'"';
import '"'"'package:rastreio_ja/features/tracking/presentation/screens/package_detail_screen.dart'"'"';
import '"'"'package:rastreio_ja/features/settings/presentation/screens/settings_screen.dart'"'"';

abstract final class AppRoutes {
  static const home          = '"'"'/'"'"';
  static const addPackage    = '"'"'/add'"'"';
  static const packageDetail = '"'"'/package/:id'"'"';
  static const settings      = '"'"'/settings'"'"';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path:    AppRoutes.home,
      builder: (final BuildContext context, final GoRouterState state) =>
          const HomeScreen(),
    ),
    GoRoute(
      path:    AppRoutes.addPackage,
      builder: (final BuildContext context, final GoRouterState state) =>
          const AddPackageScreen(),
    ),
    GoRoute(
      path: AppRoutes.packageDetail,
      builder: (final BuildContext context, final GoRouterState state) =>
          PackageDetailScreen(packageId: state.pathParameters['"'"'id'"'"'] ?? '"'"''"'"'),
    ),
    GoRoute(
      path:    AppRoutes.settings,
      builder: (final BuildContext context, final GoRouterState state) =>
          const SettingsScreen(),
    ),
  ],
);
'

mf "lib/core/storage/hive_service.dart" \
'// Rastreio Já — Inicialização do Hive
library;

import '"'"'package:hive_flutter/hive_flutter.dart'"'"';
import '"'"'package:rastreio_ja/core/constants/app_constants.dart'"'"';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<dynamic>(AppConstants.packagesBoxName);
    await Hive.openBox<dynamic>(AppConstants.settingsBoxName);
  }
}
'

mf "lib/core/theme/theme_notifier.dart" \
'// Rastreio Já — Notifier do tema
library;

import '"'"'package:flutter/material.dart'"'"';
import '"'"'package:flutter_riverpod/flutter_riverpod.dart'"'"';
import '"'"'package:rastreio_ja/core/theme/color_scheme_preset.dart'"'"';

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
'

mf "lib/core/utils/validators.dart" \
'// Rastreio Já — Validadores
library;

import '"'"'package:rastreio_ja/core/constants/app_constants.dart'"'"';
import '"'"'package:rastreio_ja/core/constants/app_strings.dart'"'"';

abstract final class Validators {
  static String? trackingCode(final String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.errorInvalidCode;
    }
    final cleaned = value.trim().toUpperCase();
    final regex   = RegExp(r'"'"'^[A-Z]{2}[0-9]{9}[A-Z]{2}$'"'"');
    if (cleaned.length != AppConstants.trackingCodeLen ||
        !regex.hasMatch(cleaned)) {
      return AppStrings.errorInvalidCode;
    }
    return null;
  }
}
'

mf "lib/features/carriers/carrier_interface.dart" \
'// Rastreio Já — Interface base para transportadoras
library;

import '"'"'package:rastreio_ja/features/tracking/domain/entities/tracking_event_entity.dart'"'"';

abstract interface class CarrierInterface {
  String get id;
  String get displayName;
  bool validateCode(final String code);
  Future<List<TrackingEventEntity>> fetchTracking(final String code);
}
'

mf "lib/features/carriers/correios/correios_service.dart" \
'// Rastreio Já — Transportadora: Correios
library;

import '"'"'package:dio/dio.dart'"'"';
import '"'"'package:rastreio_ja/features/carriers/carrier_interface.dart'"'"';
import '"'"'package:rastreio_ja/features/tracking/domain/entities/tracking_event_entity.dart'"'"';

class CorreiosService implements CarrierInterface {
  CorreiosService(this._dio);
  // ignore: unused_field
  final Dio _dio;

  @override
  String get id => '"'"'correios'"'"';

  @override
  String get displayName => '"'"'Correios'"'"';

  @override
  bool validateCode(final String code) {
    final regex = RegExp(r'"'"'^[A-Z]{2}[0-9]{9}[A-Z]{2}$'"'"');
    return regex.hasMatch(code.toUpperCase().trim());
  }

  @override
  Future<List<TrackingEventEntity>> fetchTracking(final String code) async {
    throw UnimplementedError();
  }
}
'

mf "lib/features/tracking/data/datasources/tracking_local_datasource.dart" \
'// Rastreio Já — DataSource local (Hive)
library;

import '"'"'package:hive_flutter/hive_flutter.dart'"'"';
import '"'"'package:rastreio_ja/core/constants/app_constants.dart'"'"';
import '"'"'package:rastreio_ja/features/tracking/data/models/package_model.dart'"'"';

abstract interface class TrackingLocalDataSource {
  Future<List<PackageModel>> getAllPackages();
  Future<void>               savePackage(final PackageModel package);
  Future<void>               updatePackage(final PackageModel package);
  Future<void>               deletePackage(final String id);
  PackageModel?              getPackageById(final String id);
}

class TrackingLocalDataSourceImpl implements TrackingLocalDataSource {
  Box<dynamic> get _box => Hive.box(AppConstants.packagesBoxName);

  @override
  Future<List<PackageModel>> getAllPackages() async =>
      _box.values.cast<PackageModel>().toList();

  @override
  Future<void> savePackage(final PackageModel package) async =>
      _box.put(package.id, package);

  @override
  Future<void> updatePackage(final PackageModel package) async =>
      _box.put(package.id, package);

  @override
  Future<void> deletePackage(final String id) async => _box.delete(id);

  @override
  PackageModel? getPackageById(final String id) =>
      _box.get(id) as PackageModel?;
}
'

mf "lib/features/tracking/data/datasources/tracking_remote_datasource.dart" \
'// Rastreio Já — DataSource remoto
library;

import '"'"'package:dio/dio.dart'"'"';
import '"'"'package:rastreio_ja/features/tracking/data/models/tracking_event_model.dart'"'"';

abstract interface class TrackingRemoteDataSource {
  Future<List<TrackingEventModel>> getTrackingEvents(final String code);
}

class TrackingRemoteDataSourceImpl implements TrackingRemoteDataSource {
  TrackingRemoteDataSourceImpl(this._dio);
  // ignore: unused_field
  final Dio _dio;

  @override
  Future<List<TrackingEventModel>> getTrackingEvents(
    final String code,
  ) async {
    throw UnimplementedError();
  }
}
'

mf "lib/features/tracking/data/models/package_model.dart" \
'// Rastreio Já — PackageModel (Hive entity)
library;

import '"'"'package:hive_flutter/hive_flutter.dart'"'"';

part '"'"'package_model.g.dart'"'"';

@HiveType(typeId: 0)
class PackageModel extends HiveObject {
  PackageModel({
    required this.id,
    required this.code,
    required this.carrier,
    required this.status,
    required this.createdAt,
    this.nickname,
    this.lastUpdatedAt,
    this.isDelivered = false,
  });

  @HiveField(0) String    id;
  @HiveField(1) String    code;
  @HiveField(2) String?   nickname;
  @HiveField(3) String    carrier;
  @HiveField(4) String    status;
  @HiveField(5) DateTime  createdAt;
  @HiveField(6) DateTime? lastUpdatedAt;
  @HiveField(7) bool      isDelivered;
}
'

mf "lib/features/tracking/data/repositories/tracking_repository_impl.dart" \
'// Rastreio Já — Implementação do TrackingRepository
library;

import '"'"'package:rastreio_ja/features/tracking/data/datasources/tracking_local_datasource.dart'"'"';
import '"'"'package:rastreio_ja/features/tracking/data/datasources/tracking_remote_datasource.dart'"'"';
import '"'"'package:rastreio_ja/features/tracking/domain/entities/package_entity.dart'"'"';
import '"'"'package:rastreio_ja/features/tracking/domain/repositories/tracking_repository.dart'"'"';

class TrackingRepositoryImpl implements TrackingRepository {
  TrackingRepositoryImpl({
    required this.localDs,
    required this.remoteDs,
  });

  final TrackingLocalDataSource  localDs;
  final TrackingRemoteDataSource remoteDs;

  @override
  Future<List<PackageEntity>> getAllPackages() => throw UnimplementedError();

  @override
  Future<PackageEntity> addPackage(
    final String code, {
    final String? nickname,
  }) =>
      throw UnimplementedError();

  @override
  Future<void> deletePackage(final String id) => throw UnimplementedError();

  @override
  Future<PackageEntity> refreshPackage(final String id) =>
      throw UnimplementedError();
}
'

mf "lib/features/tracking/domain/entities/package_entity.dart" \
'// Rastreio Já — PackageEntity
library;

import '"'"'package:rastreio_ja/features/tracking/domain/entities/package_status.dart'"'"';
import '"'"'package:rastreio_ja/features/tracking/domain/entities/tracking_event_entity.dart'"'"';

class PackageEntity {
  const PackageEntity({
    required this.id,
    required this.code,
    required this.carrier,
    required this.status,
    required this.createdAt,
    this.nickname,
    this.events      = const [],
    this.lastUpdatedAt,
    this.isDelivered = false,
  });

  final String                    id;
  final String                    code;
  final String?                   nickname;
  final String                    carrier;
  final PackageStatus             status;
  final List<TrackingEventEntity> events;
  final DateTime                  createdAt;
  final DateTime?                 lastUpdatedAt;
  final bool                      isDelivered;
}
'

mf "lib/features/tracking/domain/repositories/tracking_repository.dart" \
'// Rastreio Já — Interface TrackingRepository
library;

import '"'"'package:rastreio_ja/features/tracking/domain/entities/package_entity.dart'"'"';

abstract interface class TrackingRepository {
  Future<List<PackageEntity>> getAllPackages();
  Future<PackageEntity>       addPackage(final String code, {final String? nickname});
  Future<void>                deletePackage(final String id);
  Future<PackageEntity>       refreshPackage(final String id);
}
'

mf "lib/features/tracking/domain/usecases/add_package_usecase.dart" \
'// Rastreio Já — UseCase: Adicionar pacote
library;

import '"'"'package:rastreio_ja/features/tracking/domain/entities/package_entity.dart'"'"';
import '"'"'package:rastreio_ja/features/tracking/domain/repositories/tracking_repository.dart'"'"';

class AddPackageUseCase {
  AddPackageUseCase(this._repository);
  final TrackingRepository _repository;

  Future<PackageEntity> call(
    final String code, {
    final String? nickname,
  }) =>
      _repository.addPackage(code, nickname: nickname);
}
'

mf "lib/features/tracking/domain/usecases/get_packages_usecase.dart" \
'// Rastreio Já — UseCase: Buscar pacotes
library;

import '"'"'package:rastreio_ja/features/tracking/domain/entities/package_entity.dart'"'"';
import '"'"'package:rastreio_ja/features/tracking/domain/repositories/tracking_repository.dart'"'"';

class GetPackagesUseCase {
  GetPackagesUseCase(this._repository);
  final TrackingRepository _repository;

  Future<List<PackageEntity>> call() => _repository.getAllPackages();
}
'

mf "lib/features/tracking/domain/usecases/delete_package_usecase.dart" \
'// Rastreio Já — UseCase: Deletar pacote
library;

import '"'"'package:rastreio_ja/features/tracking/domain/repositories/tracking_repository.dart'"'"';

class DeletePackageUseCase {
  DeletePackageUseCase(this._repository);
  final TrackingRepository _repository;

  Future<void> call(final String id) => _repository.deletePackage(id);
}
'

mf "lib/features/tracking/domain/usecases/refresh_tracking_usecase.dart" \
'// Rastreio Já — UseCase: Atualizar rastreio
library;

import '"'"'package:rastreio_ja/features/tracking/domain/entities/package_entity.dart'"'"';
import '"'"'package:rastreio_ja/features/tracking/domain/repositories/tracking_repository.dart'"'"';

class RefreshTrackingUseCase {
  RefreshTrackingUseCase(this._repository);
  final TrackingRepository _repository;

  Future<PackageEntity> call(final String id) =>
      _repository.refreshPackage(id);
}
'

mf "lib/features/tracking/presentation/providers/packages_provider.dart" \
'// Rastreio Já — Provider dos pacotes
library;

import '"'"'package:flutter_riverpod/flutter_riverpod.dart'"'"';
import '"'"'package:rastreio_ja/features/tracking/domain/entities/package_entity.dart'"'"';

final packagesProvider =
    AsyncNotifierProvider<PackagesNotifier, List<PackageEntity>>(
  PackagesNotifier.new,
);

class PackagesNotifier extends AsyncNotifier<List<PackageEntity>> {
  @override
  Future<List<PackageEntity>> build() async => [];
}
'

mf "lib/features/settings/providers/settings_provider.dart" \
'// Rastreio Já — Provider de configurações
library;

export '"'"'package:rastreio_ja/core/theme/theme_notifier.dart'"'"' show themeProvider;
'

echo ""
echo "Correcoes aplicadas. Rodando build_runner..."
echo ""

dart run build_runner build --delete-conflicting-outputs

echo ""
echo "Pronto! Rode: flutter analyze"
echo ""
