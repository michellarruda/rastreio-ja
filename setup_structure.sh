#!/bin/bash
set -e

mk() { mkdir -p "$1"; echo "  [DIR] $1"; }
mf() {
  mkdir -p "$(dirname "$1")"
  if [ ! -f "$1" ]; then
    printf '%s' "$2" > "$1"
    echo "  [OK ] $1"
  else
    echo "  [--] ja existe: $1"
  fi
}

echo ""
echo "======================================"
echo "  Rastreio Já — Criando estrutura..."
echo "======================================"
echo ""

# Assets
mk "assets/images"
mk "assets/animations"
mk "assets/icons"
mk "assets/fonts"

# Tests
mk "test/unit/tracking"
mk "test/unit/theme"
mk "test/widget"
mk "test/integration"

echo ""
echo "[1/9] Core / Constants..."

mf "lib/core/constants/app_colors.dart" \
'// Rastreio Já — Paleta de cores base
library;

import '"'"'package:flutter/material.dart'"'"';

abstract final class AppColors {
  static const tealPrimary     = Color(0xFF2ECFCF);
  static const tealLight       = Color(0xFF4ADEDE);
  static const tealDark        = Color(0xFF1DA8A8);
  static const accentYellow    = Color(0xFFF5A623);
  static const accentOrange    = Color(0xFFFF8E53);

  static const backgroundLight = Color(0xFFF5FFFE);
  static const surfaceLight    = Color(0xFFFFFFFF);
  static const backgroundDark  = Color(0xFF0F1923);
  static const surfaceDark     = Color(0xFF1A2633);

  static const success = Color(0xFF27AE60);
  static const warning = Color(0xFFF39C12);
  static const error   = Color(0xFFE74C3C);
  static const info    = Color(0xFF3498DB);

  static const textPrimaryLight   = Color(0xFF1A1A2E);
  static const textSecondaryLight = Color(0xFF6B7280);
  static const textPrimaryDark    = Color(0xFFF1F5F9);
  static const textSecondaryDark  = Color(0xFF94A3B8);
}
'

mf "lib/core/constants/app_strings.dart" \
'// Rastreio Já — Strings e labels
library;

abstract final class AppStrings {
  static const appName       = '"'"'Rastreio Já'"'"';
  static const appTagline    = '"'"'Seus pacotes, sempre em vista'"'"';
  static const appVersion    = '"'"'1.0.0'"'"';

  static const homeTitle         = '"'"'Meus Pacotes'"'"';
  static const homeEmpty         = '"'"'Nenhum pacote cadastrado ainda'"'"';
  static const homeEmptySubtitle = '"'"'Toque no + para adicionar seu primeiro rastreio'"'"';

  static const addPackageTitle     = '"'"'Adicionar Pacote'"'"';
  static const addPackageCodeLabel = '"'"'Código de rastreio'"'"';
  static const addPackageCodeHint  = '"'"'Ex: BR123456789BR'"'"';
  static const addPackageNameLabel = '"'"'Apelido (opcional)'"'"';
  static const addPackageNameHint  = '"'"'Ex: Tenis Nike, Pedido 123'"'"';
  static const addPackageButton    = '"'"'Adicionar'"'"';

  static const detailTitle      = '"'"'Detalhes do Pacote'"'"';
  static const detailRefresh    = '"'"'Atualizar'"'"';
  static const detailLastUpdate = '"'"'Ultima atualizacao'"'"';

  static const settingsTitle       = '"'"'Configuracoes'"'"';
  static const settingsTheme       = '"'"'Tema do aplicativo'"'"';
  static const settingsThemeLight  = '"'"'Claro'"'"';
  static const settingsThemeDark   = '"'"'Escuro'"'"';
  static const settingsThemeSystem = '"'"'Seguir sistema'"'"';
  static const settingsColorPreset = '"'"'Esquema de cores'"'"';

  static const errorGeneric     = '"'"'Algo deu errado. Tente novamente.'"'"';
  static const errorNetwork     = '"'"'Sem conexao com a internet.'"'"';
  static const errorNotFound    = '"'"'Codigo de rastreio nao encontrado.'"'"';
  static const errorInvalidCode = '"'"'Codigo de rastreio invalido.'"'"';

  static const statusPosted    = '"'"'Postado'"'"';
  static const statusInTransit = '"'"'Em transito'"'"';
  static const statusOutForDel = '"'"'Saiu para entrega'"'"';
  static const statusDelivered = '"'"'Entregue'"'"';
  static const statusAlert     = '"'"'Requer atencao'"'"';
  static const statusUnknown   = '"'"'Status desconhecido'"'"';
}
'

mf "lib/core/constants/app_constants.dart" \
'// Rastreio Já — Constantes gerais
library;

abstract final class AppConstants {
  static const cacheDurationHours = 2;
  static const maxPackagesPerUser = 50;

  static const packagesBoxName = '"'"'rastreio_ja_packages'"'"';
  static const settingsBoxName = '"'"'rastreio_ja_settings'"'"';

  static const prefThemeMode   = '"'"'pref_theme_mode'"'"';
  static const prefColorPreset = '"'"'pref_color_preset'"'"';

  static const apiBaseUrl       = '"'"'https://api.seurastreio.com.br'"'"';
  static const apiTimeout       = 15000;
  static const apiRetryAttempts = 3;

  static const trackingCodeLen = 13;
}
'

echo ""
echo "[2/9] Core / Theme..."

mf "lib/core/theme/app_theme.dart" \
'// Rastreio Já — ThemeData principal
library;

import '"'"'package:flutter/material.dart'"'"';

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
'

mf "lib/core/theme/color_scheme_preset.dart" \
'// Rastreio Já — Presets de esquemas de cor
library;

import '"'"'package:flutter/material.dart'"'"';

enum AppColorPreset { vitality, ocean, sunset, minimal }

class ColorSchemePresets {
  static ColorScheme light(final AppColorPreset preset) {
    return switch (preset) {
      AppColorPreset.vitality => const ColorScheme.light(
          primary: Color(0xFF2ECFCF),
          secondary: Color(0xFF4ADEDE),
          tertiary: Color(0xFFF5A623),
        ),
      AppColorPreset.ocean => const ColorScheme.light(
          primary: Color(0xFF1A73E8),
          secondary: Color(0xFF4FC3F7),
          tertiary: Color(0xFF00BCD4),
        ),
      AppColorPreset.sunset => const ColorScheme.light(
          primary: Color(0xFFFF6B6B),
          secondary: Color(0xFFFFB347),
          tertiary: Color(0xFFFF8E53),
        ),
      AppColorPreset.minimal => const ColorScheme.light(
          primary: Color(0xFF2D3436),
          secondary: Color(0xFF636E72),
          tertiary: Color(0xFF0984E3),
        ),
    };
  }

  static ColorScheme dark(final AppColorPreset preset) {
    return switch (preset) {
      AppColorPreset.vitality => const ColorScheme.dark(
          primary: Color(0xFF2ECFCF),
          secondary: Color(0xFF4ADEDE),
          tertiary: Color(0xFFF5A623),
        ),
      AppColorPreset.ocean => const ColorScheme.dark(
          primary: Color(0xFF4FC3F7),
          secondary: Color(0xFF1A73E8),
          tertiary: Color(0xFF00BCD4),
        ),
      AppColorPreset.sunset => const ColorScheme.dark(
          primary: Color(0xFFFF6B6B),
          secondary: Color(0xFFFFB347),
          tertiary: Color(0xFFFF8E53),
        ),
      AppColorPreset.minimal => const ColorScheme.dark(
          primary: Color(0xFFDFE6E9),
          secondary: Color(0xFFB2BEC3),
          tertiary: Color(0xFF74B9FF),
        ),
    };
  }
}
'

mf "lib/core/theme/theme_notifier.dart" \
'// Rastreio Já — Notifier do tema
library;

import '"'"'package:flutter/material.dart'"'"';
import '"'"'package:flutter_riverpod/flutter_riverpod.dart'"'"';
import '"'"'color_scheme_preset.dart'"'"';

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

echo ""
echo "[3/9] Core / Router..."

mf "lib/core/router/app_router.dart" \
'// Rastreio Já — Rotas (GoRouter)
library;

import '"'"'package:flutter/material.dart'"'"';
import '"'"'package:go_router/go_router.dart'"'"';
import '"'"'../../features/tracking/presentation/screens/home_screen.dart'"'"';
import '"'"'../../features/tracking/presentation/screens/add_package_screen.dart'"'"';
import '"'"'../../features/tracking/presentation/screens/package_detail_screen.dart'"'"';
import '"'"'../../features/settings/presentation/screens/settings_screen.dart'"'"';

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

echo ""
echo "[4/9] Core / Network..."

mf "lib/core/network/dio_client.dart" \
'// Rastreio Já — Cliente HTTP (Dio)
library;

import '"'"'package:dio/dio.dart'"'"';
import '"'"'../constants/app_constants.dart'"'"';

Dio createDioClient() {
  final dio = Dio(
    BaseOptions(
      baseUrl:        AppConstants.apiBaseUrl,
      connectTimeout: Duration(milliseconds: AppConstants.apiTimeout),
      receiveTimeout: Duration(milliseconds: AppConstants.apiTimeout),
      headers: {'"'"'Content-Type'"'"': '"'"'application/json'"'"'},
    ),
  );
  return dio;
}
'

mf "lib/core/network/network_exception.dart" \
'// Rastreio Já — Exceções de rede
library;

sealed class NetworkException implements Exception {
  const NetworkException(this.message);
  final String message;
}

final class NoInternetException extends NetworkException {
  const NoInternetException() : super('"'"'Sem conexao com a internet.'"'"');
}

final class NotFoundException extends NetworkException {
  const NotFoundException() : super('"'"'Recurso nao encontrado.'"'"');
}

final class ServerException extends NetworkException {
  const ServerException(super.message);
}

final class RequestTimeoutException extends NetworkException {
  const RequestTimeoutException() : super('"'"'Tempo de requisicao esgotado.'"'"');
}
'

echo ""
echo "[5/9] Core / Storage..."

mf "lib/core/storage/hive_service.dart" \
'// Rastreio Já — Inicialização do Hive
library;

import '"'"'package:hive_flutter/hive_flutter.dart'"'"';
import '"'"'../constants/app_constants.dart'"'"';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<dynamic>(AppConstants.packagesBoxName);
    await Hive.openBox<dynamic>(AppConstants.settingsBoxName);
  }
}
'

mf "lib/core/storage/preferences_service.dart" \
'// Rastreio Já — Wrapper SharedPreferences
library;

import '"'"'package:shared_preferences/shared_preferences.dart'"'"';

class PreferencesService {
  PreferencesService(this._prefs);
  final SharedPreferences _prefs;

  Future<bool> setString(final String key, final String value) =>
      _prefs.setString(key, value);

  String? getString(final String key) => _prefs.getString(key);

  Future<bool> setInt(final String key, final int value) =>
      _prefs.setInt(key, value);

  int? getInt(final String key) => _prefs.getInt(key);

  Future<bool> remove(final String key) => _prefs.remove(key);
}
'

echo ""
echo "[6/9] Core / Utils..."

mf "lib/core/utils/date_formatter.dart" \
'// Rastreio Já — Formatadores de data
library;

import '"'"'package:intl/intl.dart'"'"';

abstract final class DateFormatter {
  static final _full     = DateFormat("dd/MM/yyyy '"'"'as'"'"' HH:mm", '"'"'pt_BR'"'"');
  static final _short    = DateFormat('"'"'dd/MM/yyyy'"'"', '"'"'pt_BR'"'"');
  static final _time     = DateFormat('"'"'HH:mm'"'"', '"'"'pt_BR'"'"');
  static final _relative = DateFormat('"'"'EEE, dd MMM'"'"', '"'"'pt_BR'"'"');

  static String full(final DateTime dt)     => _full.format(dt);
  static String short(final DateTime dt)    => _short.format(dt);
  static String time(final DateTime dt)     => _time.format(dt);
  static String relative(final DateTime dt) => _relative.format(dt);
}
'

mf "lib/core/utils/validators.dart" \
'// Rastreio Já — Validadores
library;

import '"'"'../constants/app_constants.dart'"'"';
import '"'"'../constants/app_strings.dart'"'"';

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

echo ""
echo "[7/9] Feature: Tracking..."

mf "lib/features/tracking/data/models/package_model.dart" \
'// Rastreio Já — PackageModel (Hive entity)
library;

import '"'"'package:hive/hive.dart'"'"';

part '"'"'package_model.g.dart'"'"';

@HiveType(typeId: 0)
class PackageModel extends HiveObject {
  PackageModel({
    required this.id,
    required this.code,
    this.nickname,
    required this.carrier,
    required this.status,
    required this.createdAt,
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

mf "lib/features/tracking/data/models/tracking_event_model.dart" \
'// Rastreio Já — TrackingEventModel
library;

class TrackingEventModel {
  const TrackingEventModel({
    required this.description,
    required this.location,
    required this.timestamp,
    this.detail,
  });

  factory TrackingEventModel.fromJson(final Map<String, dynamic> json) =>
      TrackingEventModel(
        description: json['"'"'descricao'"'"'] as String,
        location:    json['"'"'local'"'"']     as String,
        timestamp:   DateTime.parse(json['"'"'data'"'"'] as String),
        detail:      json['"'"'detalhe'"'"']   as String?,
      );

  final String   description;
  final String   location;
  final DateTime timestamp;
  final String?  detail;
}
'

mf "lib/features/tracking/data/datasources/tracking_remote_datasource.dart" \
'// Rastreio Já — DataSource remoto
library;

import '"'"'package:dio/dio.dart'"'"';
import '"'"'../models/tracking_event_model.dart'"'"';

abstract interface class TrackingRemoteDataSource {
  Future<List<TrackingEventModel>> getTrackingEvents(final String code);
}

class TrackingRemoteDataSourceImpl implements TrackingRemoteDataSource {
  TrackingRemoteDataSourceImpl(this._dio);
  final Dio _dio;

  @override
  Future<List<TrackingEventModel>> getTrackingEvents(
    final String code,
  ) async {
    throw UnimplementedError();
  }
}
'

mf "lib/features/tracking/data/datasources/tracking_local_datasource.dart" \
'// Rastreio Já — DataSource local (Hive)
library;

import '"'"'package:hive/hive.dart'"'"';
import '"'"'../models/package_model.dart'"'"';
import '"'"'../../../../core/constants/app_constants.dart'"'"';

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

mf "lib/features/tracking/data/repositories/tracking_repository_impl.dart" \
'// Rastreio Já — Implementação do TrackingRepository
library;

import '"'"'../../domain/entities/package_entity.dart'"'"';
import '"'"'../../domain/repositories/tracking_repository.dart'"'"';
import '"'"'../datasources/tracking_local_datasource.dart'"'"';
import '"'"'../datasources/tracking_remote_datasource.dart'"'"';

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

mf "lib/features/tracking/domain/entities/package_status.dart" \
'// Rastreio Já — Enum de status do pacote
library;

enum PackageStatus {
  unknown,
  posted,
  inTransit,
  outForDelivery,
  delivered,
  alert,
  returned,
}
'

mf "lib/features/tracking/domain/entities/tracking_event_entity.dart" \
'// Rastreio Já — TrackingEventEntity
library;

class TrackingEventEntity {
  const TrackingEventEntity({
    required this.description,
    required this.location,
    required this.timestamp,
    this.detail,
  });

  final String   description;
  final String   location;
  final DateTime timestamp;
  final String?  detail;
}
'

mf "lib/features/tracking/domain/entities/package_entity.dart" \
'// Rastreio Já — PackageEntity
library;

import '"'"'package_status.dart'"'"';
import '"'"'tracking_event_entity.dart'"'"';

class PackageEntity {
  const PackageEntity({
    required this.id,
    required this.code,
    this.nickname,
    required this.carrier,
    required this.status,
    this.events      = const [],
    required this.createdAt,
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

import '"'"'../entities/package_entity.dart'"'"';

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

import '"'"'../entities/package_entity.dart'"'"';
import '"'"'../repositories/tracking_repository.dart'"'"';

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

import '"'"'../entities/package_entity.dart'"'"';
import '"'"'../repositories/tracking_repository.dart'"'"';

class GetPackagesUseCase {
  GetPackagesUseCase(this._repository);
  final TrackingRepository _repository;

  Future<List<PackageEntity>> call() => _repository.getAllPackages();
}
'

mf "lib/features/tracking/domain/usecases/delete_package_usecase.dart" \
'// Rastreio Já — UseCase: Deletar pacote
library;

import '"'"'../repositories/tracking_repository.dart'"'"';

class DeletePackageUseCase {
  DeletePackageUseCase(this._repository);
  final TrackingRepository _repository;

  Future<void> call(final String id) => _repository.deletePackage(id);
}
'

mf "lib/features/tracking/domain/usecases/refresh_tracking_usecase.dart" \
'// Rastreio Já — UseCase: Atualizar rastreio
library;

import '"'"'../entities/package_entity.dart'"'"';
import '"'"'../repositories/tracking_repository.dart'"'"';

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
import '"'"'../../domain/entities/package_entity.dart'"'"';

final packagesProvider =
    AsyncNotifierProvider<PackagesNotifier, List<PackageEntity>>(
  PackagesNotifier.new,
);

class PackagesNotifier extends AsyncNotifier<List<PackageEntity>> {
  @override
  Future<List<PackageEntity>> build() async => [];
}
'

mf "lib/features/tracking/presentation/screens/home_screen.dart" \
'// Rastreio Já — Tela principal (placeholder)
library;

import '"'"'package:flutter/material.dart'"'"';
import '"'"'package:flutter_riverpod/flutter_riverpod.dart'"'"';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    return const Scaffold(
      body: Center(child: Text('"'"'Rastreio Já — Home'"'"')),
    );
  }
}
'

mf "lib/features/tracking/presentation/screens/add_package_screen.dart" \
'// Rastreio Já — Tela adicionar pacote (placeholder)
library;

import '"'"'package:flutter/material.dart'"'"';
import '"'"'package:flutter_riverpod/flutter_riverpod.dart'"'"';

class AddPackageScreen extends ConsumerWidget {
  const AddPackageScreen({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    return const Scaffold(
      body: Center(child: Text('"'"'Adicionar Pacote'"'"')),
    );
  }
}
'

mf "lib/features/tracking/presentation/screens/package_detail_screen.dart" \
'// Rastreio Já — Tela detalhes (placeholder)
library;

import '"'"'package:flutter/material.dart'"'"';
import '"'"'package:flutter_riverpod/flutter_riverpod.dart'"'"';

class PackageDetailScreen extends ConsumerWidget {
  const PackageDetailScreen({required this.packageId, super.key});
  final String packageId;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    return Scaffold(
      body: Center(child: Text('"'"'Pacote: $packageId'"'"')),
    );
  }
}
'

mf "lib/features/tracking/presentation/widgets/package_card.dart" \
'// Rastreio Já — Widget: Card de pacote (placeholder)
library;

import '"'"'package:flutter/material.dart'"'"';

class PackageCard extends StatelessWidget {
  const PackageCard({super.key});

  @override
  Widget build(final BuildContext context) => const Placeholder();
}
'

mf "lib/features/tracking/presentation/widgets/tracking_timeline.dart" \
'// Rastreio Já — Widget: Timeline (placeholder)
library;

import '"'"'package:flutter/material.dart'"'"';

class TrackingTimeline extends StatelessWidget {
  const TrackingTimeline({super.key});

  @override
  Widget build(final BuildContext context) => const Placeholder();
}
'

mf "lib/features/tracking/presentation/widgets/status_badge.dart" \
'// Rastreio Já — Widget: Badge de status (placeholder)
library;

import '"'"'package:flutter/material.dart'"'"';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key});

  @override
  Widget build(final BuildContext context) => const Placeholder();
}
'

echo ""
echo "[8/9] Feature: Settings + Carriers..."

mf "lib/features/settings/presentation/screens/settings_screen.dart" \
'// Rastreio Já — Tela de configurações (placeholder)
library;

import '"'"'package:flutter/material.dart'"'"';
import '"'"'package:flutter_riverpod/flutter_riverpod.dart'"'"';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    return const Scaffold(
      body: Center(child: Text('"'"'Configurações'"'"')),
    );
  }
}
'

mf "lib/features/settings/presentation/widgets/theme_picker.dart" \
'// Rastreio Já — Widget: Seletor de tema (placeholder)
library;

import '"'"'package:flutter/material.dart'"'"';

class ThemePicker extends StatelessWidget {
  const ThemePicker({super.key});

  @override
  Widget build(final BuildContext context) => const Placeholder();
}
'

mf "lib/features/settings/providers/settings_provider.dart" \
'// Rastreio Já — Provider de configurações
library;

export '"'"'../../../core/theme/theme_notifier.dart'"'"' show themeProvider;
'

mf "lib/features/carriers/carrier_interface.dart" \
'// Rastreio Já — Interface base para transportadoras
library;

import '"'"'../tracking/domain/entities/tracking_event_entity.dart'"'"';

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
import '"'"'../carrier_interface.dart'"'"';
import '"'"'../../tracking/domain/entities/tracking_event_entity.dart'"'"';

class CorreiosService implements CarrierInterface {
  CorreiosService(this._dio);
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

echo ""
echo "[9/9] Entry points + Testes..."

mf "lib/app.dart" \
'// Rastreio Já — Root Widget
library;

import '"'"'package:flutter/material.dart'"'"';
import '"'"'package:flutter_riverpod/flutter_riverpod.dart'"'"';
import '"'"'core/router/app_router.dart'"'"';
import '"'"'core/theme/app_theme.dart'"'"';
import '"'"'core/theme/color_scheme_preset.dart'"'"';
import '"'"'core/theme/theme_notifier.dart'"'"';

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
import '"'"'app.dart'"'"';
import '"'"'core/storage/hive_service.dart'"'"';

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

mf "test/unit/tracking/add_package_usecase_test.dart" \
'// Rastreio Já — Teste: AddPackageUseCase
library;

import '"'"'package:flutter_test/flutter_test.dart'"'"';

void main() {
  group('"'"'AddPackageUseCase'"'"', () {
    test('"'"'placeholder'"'"', () => expect(true, isTrue));
  });
}
'

echo ""
echo "========================================="
echo "  Rastreio Já — Estrutura criada!        "
echo "========================================="
echo ""
echo "  Proximos passos:"
echo "  1. dart run build_runner build --delete-conflicting-outputs"
echo "  2. flutter analyze"
echo "  3. flutter run -d chrome"
echo ""
