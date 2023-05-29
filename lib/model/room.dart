import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../controller/user_controller.dart';

part 'room.g.dart';

@HiveType(typeId: 2)
class Room {
  Room({this.roomId = '', this.roomTitle = '', this.createMember = ''});

  @HiveField(0)
  String roomId;

  @HiveField(1)
  String createMember;

  @HiveField(2)
  List<String> joinMember = [];

  @HiveField(3)
  String roomTitle;

  @HiveField(4)
  String meetDate = '';

  @HiveField(5)
  String meetTime = '';

  Timestamp? createTime;

  @HiveField(6)
  int notificationId = -1;

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
