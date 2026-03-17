// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PackageModelAdapter extends TypeAdapter<PackageModel> {
  @override
  final int typeId = 0;

  @override
  PackageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PackageModel(
      id: fields[0] as String,
      trackingCode: fields[1] as String,
      label: fields[2] as String,
      carrier: fields[3] as String,
      status: fields[4] as String,
      events: (fields[5] as List).cast<TrackingEventModel>(),
      createdAt: fields[6] as String,
      lastUpdatedAt: fields[7] as String,
      estimatedDelivery: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PackageModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.trackingCode)
      ..writeByte(2)
      ..write(obj.label)
      ..writeByte(3)
      ..write(obj.carrier)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.events)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.lastUpdatedAt)
      ..writeByte(8)
      ..write(obj.estimatedDelivery);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PackageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
