// Rastreio Já — PackageModel (Hive entity)
library;

import 'package:hive_flutter/hive_flutter.dart';

part 'package_model.g.dart';

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
