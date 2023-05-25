// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'come_together_config.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ComeTogetherConfigAdapter extends TypeAdapter<ComeTogetherConfig> {
  @override
  final int typeId = 3;

  @override
  ComeTogetherConfig read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ComeTogetherConfig(
      isDarkMode: fields[0] as bool,
      isFirstRun: fields[1] as bool,
      beforeMiniute: fields[2] as int,
      isShowAlarm: fields[3] as bool,
    )..lastSyncFriendsTime = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, ComeTogetherConfig obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.isDarkMode)
      ..writeByte(1)
      ..write(obj.isFirstRun)
      ..writeByte(2)
      ..write(obj.beforeMiniute)
      ..writeByte(3)
      ..write(obj.isShowAlarm)
      ..writeByte(4)
      ..write(obj.lastSyncFriendsTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComeTogetherConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
