import 'dart:convert';

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
        memberIcon = json['userIcon'] {
    String? jsonString = json['friends'];
    if (jsonString != null) {
      List<FriendInfo> loadedFriends = [];
      for (var data in jsonDecode(jsonString)) {
        loadedFriends.add(FriendInfo.fromJson(data));
      }
      friends = loadedFriends;
    } else {
      friends = null;
    }
  }

  Map<String, dynamic> toJson() => {
        'memberId': memberId,
        'memberEmail': memberEmail,
        'nickname': memberNickname,
        'userIcon': memberIcon,
        'friends': jsonEncode(friends)
      };

  void updateModule() {
    update();
  }
}
