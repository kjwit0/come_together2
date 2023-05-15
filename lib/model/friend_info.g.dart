// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FriendInfoAdapter extends TypeAdapter<FriendInfo> {
  @override
  final int typeId = 1;

  @override
  FriendInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FriendInfo(
      memberId: fields[0] as String,
      memberNickname: fields[1] as String,
      memberIcon: fields[2] as String,
      memberEmail: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FriendInfo obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.memberId)
      ..writeByte(1)
      ..write(obj.memberNickname)
      ..writeByte(2)
      ..write(obj.memberIcon)
      ..writeByte(3)
      ..write(obj.memberEmail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FriendInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
