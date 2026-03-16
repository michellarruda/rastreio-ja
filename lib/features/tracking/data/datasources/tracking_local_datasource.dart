// Rastreio Já — DataSource local (Hive)
library;

import 'package:hive_flutter/hive_flutter.dart';
import 'package:rastreio_ja/core/constants/app_constants.dart';
import 'package:rastreio_ja/features/tracking/data/models/package_model.dart';

abstract interface class TrackingLocalDataSource {
  Future<List<PackageModel>> getAllPackages();
  Future<void> savePackage(final PackageModel package);
  Future<void> updatePackage(final PackageModel package);
  Future<void> deletePackage(final String id);
  PackageModel? getPackageById(final String id);
}

class TrackingLocalDataSourceImpl implements TrackingLocalDataSource {
  Box<PackageModel> get _box =>
      Hive.box<PackageModel>(AppConstants.packagesBoxName);

  @override
  Future<List<PackageModel>> getAllPackages() async => _box.values.toList();

  @override
  Future<void> savePackage(final PackageModel package) async =>
      _box.put(package.id, package);

  @override
  Future<void> updatePackage(final PackageModel package) async =>
      _box.put(package.id, package);

  @override
  Future<void> deletePackage(final String id) async => _box.delete(id);

  @override
  PackageModel? getPackageById(final String id) => _box.get(id);
}
