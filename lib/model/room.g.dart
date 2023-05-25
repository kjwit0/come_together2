// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoomAdapter extends TypeAdapter<Room> {
  @override
  final int typeId = 2;

  @override
  Room read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Room(
      roomId: fields[0] as String,
      roomTitle: fields[3] as String,
      createMember: fields[1] as String,
    )
      ..joinMember = (fields[2] as List).cast<String>()
      ..meetDate = fields[4] as String
      ..meetTime = fields[5] as String
      ..notificationId = fields[6] as int;
  }

  @override
  void write(BinaryWriter writer, Room obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.roomId)
      ..writeByte(1)
      ..write(obj.createMember)
      ..writeByte(2)
      ..write(obj.joinMember)
      ..writeByte(3)
      ..write(obj.roomTitle)
      ..writeByte(4)
      ..write(obj.meetDate)
      ..writeByte(5)
      ..write(obj.meetTime)
      ..writeByte(6)
      ..write(obj.notificationId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoomAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
