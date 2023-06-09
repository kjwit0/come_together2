import 'package:hive_flutter/adapters.dart';

part 'friend_info.g.dart';

@HiveType(typeId: 1)
class FriendInfo extends HiveObject {
  FriendInfo(
      {required this.memberId,
      required this.memberNickname,
      required this.memberIcon});

  @HiveField(0)
  String memberId;

  @HiveField(1)
  String memberNickname;

  @HiveField(2)
  String memberIcon;
}
