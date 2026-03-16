// Rastreio Já — Interface TrackingRepository
library;

import 'package:rastreio_ja/features/tracking/domain/entities/package_entity.dart';

abstract interface class TrackingRepository {
  Future<List<PackageEntity>> getAllPackages();
  Future<PackageEntity>       addPackage(final String code, {final String? nickname});
  Future<void>                deletePackage(final String id);
  Future<PackageEntity>       refreshPackage(final String id);
}
