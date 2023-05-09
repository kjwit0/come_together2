import 'package:get/get.dart';
import 'friend_info.dart';

class Member extends GetxController {
  Member(
      {this.memberId = '',
      this.memberEmail = '',
      this.memberNickname = '',
      this.memberIcon = 'none'});

  String memberId;
  String memberEmail;
  String memberNickname;
  String? memberIcon;
  List<FriendInfo>? friends;

  Member.fromJson(Map<String, dynamic> json)
      : memberId = json['memberId'],
        memberEmail = json['memberEmail'],
        memberNickname = json['nickname'],
        memberIcon = json['userIcon'],
        friends = json['friends'];

  Map<String, dynamic> toJson() => {
        'memberId': memberId,
        'memberEmail': memberEmail,
        'memberNickname': memberNickname,
        'userIcon': memberIcon,
        'friends': friends
      };
  void updateModule() {
    update();
  }
}
