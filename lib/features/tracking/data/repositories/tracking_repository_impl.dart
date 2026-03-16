// Rastreio Já — Implementação do TrackingRepository
library;

import 'package:rastreio_ja/features/tracking/data/datasources/tracking_local_datasource.dart';
import 'package:rastreio_ja/features/tracking/data/datasources/tracking_remote_datasource.dart';
import 'package:rastreio_ja/features/tracking/domain/entities/package_entity.dart';
import 'package:rastreio_ja/features/tracking/domain/repositories/tracking_repository.dart';

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
