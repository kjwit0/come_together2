import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'friend_info.dart';

class Room {
  Room({this.roomId = '', this.createMemberId = ''});

  String roomId;
  String createMemberId;
  List<FriendInfo>? joinMember = [];
  late String meetTime;
  Timestamp? createTime;

  Room.fromJson(Map<String, dynamic> json)
      : roomId = json['roomId'],
        createMemberId = json['createMemberId'],
        meetTime = json['meetTime'],
        createTime = json['createTime'] {
    String? jsonString = json['joinMember'];
    if (jsonString != null) {
      List<FriendInfo> loadedFriends = [];
      for (var data in jsonDecode(jsonString)) {
        loadedFriends.add(FriendInfo.fromJson(data));
      }
      joinMember = loadedFriends;
    } else {
      joinMember = null;
    }
  }

  Map<String, dynamic> toJson() => {
        'roomId': roomId,
        'createMemberId': createMemberId,
        'meetTime': meetTime,
        'joinMember': jsonEncode(joinMember),
        'createTime': createTime
      };
}
