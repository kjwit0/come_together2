import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:come_together2/controller/user_controller.dart';

class Room {
  Room({this.roomId = '', this.roomTitle = '', this.createMember = ''});

  String roomId;
  String createMember;
  List<String> joinMember = [];
  String roomTitle;
  String meetDate = '';
  String meetTime = '';
  Timestamp? createTime;

  Room.fromJson(Map<String, dynamic> json)
      : roomId = json['roomId'],
        createMember = json['createMember'],
        roomTitle = json['roomTitle'],
        meetTime = json['meetTime'],
        meetDate = json['meetDate'],
        createTime = json['createTime'],
        joinMember = List<String>.from(json['joinMember']);

  Map<String, dynamic> toJson() => {
        'roomId': roomId,
        'createMember': UserController.to.loginUser.value.memberId,
        'roomTitle': roomTitle,
        'meetTime': meetTime,
        'meetDate': meetDate,
        'joinMember': joinMember,
        'createTime': createTime
      };
}
