// Rastreio Já — Provider dos pacotes
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rastreio_ja/features/tracking/domain/entities/package_entity.dart';

final packagesProvider =
    AsyncNotifierProvider<PackagesNotifier, List<PackageEntity>>(
  PackagesNotifier.new,
);

class PackagesNotifier extends AsyncNotifier<List<PackageEntity>> {
  @override
  Future<List<PackageEntity>> build() async => [];
}
