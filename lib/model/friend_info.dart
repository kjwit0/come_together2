import 'package:hive_flutter/adapters.dart';

part 'friend_info.g.dart';

@HiveType(typeId: 1)
class FriendInfo extends HiveObject {
  FriendInfo(
      {this.memberId = '',
      this.memberNickname = '',
      this.memberIcon = '',
      this.memberEmail = ''});

  @HiveField(0)
  String memberId;

  @HiveField(1)
  String memberNickname;

  @HiveField(2)
  String memberIcon;

  @HiveField(3)
  String memberEmail;

  FriendInfo.fromJson(Map<String, dynamic> json)
      : memberId = json['memberId'],
        memberNickname = json['nickname'],
        memberIcon = json['userIcon'],
        memberEmail = json['memberEmail'];

  Map<String, dynamic> toJson() => {
        'memberId': memberId,
        'nickname': memberNickname,
        'userIcon': memberIcon,
        'memberEmail': memberEmail
      };

  bool equalData(FriendInfo friend) {
    return (memberNickname == friend.memberNickname) &&
        (memberIcon == friend.memberIcon);
  }
}
