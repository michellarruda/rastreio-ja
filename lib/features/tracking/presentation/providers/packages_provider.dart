// Rastreio Já — Providers de rastreamento (Riverpod)
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rastreio_ja/core/network/dio_client.dart';
import 'package:rastreio_ja/core/storage/hive_service.dart';
import 'package:rastreio_ja/features/tracking/data/datasources/tracking_local_datasource.dart';
import 'package:rastreio_ja/features/tracking/data/datasources/tracking_remote_datasource.dart';
import 'package:rastreio_ja/features/tracking/data/repositories/tracking_repository_impl.dart';
import 'package:rastreio_ja/features/tracking/domain/entities/package_entity.dart';
import 'package:rastreio_ja/features/tracking/domain/repositories/tracking_repository.dart';
import 'package:rastreio_ja/features/tracking/domain/usecases/add_package_usecase.dart';
import 'package:rastreio_ja/features/tracking/domain/usecases/delete_package_usecase.dart';
import 'package:rastreio_ja/features/tracking/domain/usecases/get_packages_usecase.dart';
import 'package:rastreio_ja/features/tracking/domain/usecases/refresh_tracking_usecase.dart';

// -------------------------------------------------------
// Infra providers
// -------------------------------------------------------

final dioClientProvider = Provider(
  (final Ref ref) => createDioClient(),
);

final localDataSourceProvider = Provider<TrackingLocalDataSource>(
  (final Ref ref) => TrackingLocalDataSourceImpl(),
);

final remoteDataSourceProvider = Provider<TrackingRemoteDataSource>(
  (final Ref ref) => TrackingRemoteDataSourceImpl(
    dio: ref.watch(dioClientProvider),
  ),
);

final trackingRepositoryProvider = Provider<TrackingRepository>(
  (final Ref ref) => TrackingRepositoryImpl(
    local: ref.watch(localDataSourceProvider),
    remote: ref.watch(remoteDataSourceProvider),
    hiveBox: HiveService.packagesBox,
  ),
);

// -------------------------------------------------------
// UseCase providers
// -------------------------------------------------------

final addPackageUseCaseProvider = Provider(
  (final Ref ref) => AddPackageUseCase(ref.watch(trackingRepositoryProvider)),
);

final getPackagesUseCaseProvider = Provider(
  (final Ref ref) => GetPackagesUseCase(ref.watch(trackingRepositoryProvider)),
);

final deletePackageUseCaseProvider = Provider(
  (final Ref ref) =>
      DeletePackageUseCase(ref.watch(trackingRepositoryProvider)),
);

final refreshTrackingUseCaseProvider = Provider(
  (final Ref ref) =>
      RefreshTrackingUseCase(ref.watch(trackingRepositoryProvider)),
);

// -------------------------------------------------------
// State — lista de pacotes
// -------------------------------------------------------

final packagesProvider =
    AsyncNotifierProvider<PackagesNotifier, List<PackageEntity>>(
  PackagesNotifier.new,
);

class PackagesNotifier extends AsyncNotifier<List<PackageEntity>> {
  @override
  Future<List<PackageEntity>> build() =>
      ref.watch(getPackagesUseCaseProvider).call();

  Future<void> addPackage({
    required final String code,
    final String? nickname,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(addPackageUseCaseProvider).call(code, nickname: nickname);
      return ref.read(getPackagesUseCaseProvider).call();
    });
  }

  Future<void> deletePackage(final String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(deletePackageUseCaseProvider).call(id);
      return ref.read(getPackagesUseCaseProvider).call();
    });
  }

  Future<void> refreshPackage(final String id) async {
    final current = state.valueOrNull ?? [];
    state = AsyncData(
      current
          .map(
            (final p) => p.id == id ? p.copyWith(isRefreshing: true) : p,
          )
          .toList(),
    );
    state = await AsyncValue.guard(() async {
      await ref.read(refreshTrackingUseCaseProvider).call(id);
      return ref.read(getPackagesUseCaseProvider).call();
    });
  }

  Future<void> refreshAll() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(getPackagesUseCaseProvider).call(),
    );
  }
}

// -------------------------------------------------------
// Provider de pacote individual (tela de detalhe)
// -------------------------------------------------------

final packageByIdProvider = Provider.family<PackageEntity?, String>(
  (final Ref ref, final String id) {
    final packages = ref.watch(packagesProvider).valueOrNull ?? [];
    return packages.where((final p) => p.id == id).firstOrNull;
  },
);
