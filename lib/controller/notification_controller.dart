import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:come_together2/controller/user_controller.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../model/notification.dart';
import '../model/room.dart';

class NotificationController {
  NotificationController._();
  static final NotificationController _instance = NotificationController._();
  static final Map<String, Room> notificationMap = {};
  int keyNum = -1;

  factory NotificationController() {
    return _instance;
  }

  void loadLocalKeyNum() {
    keyNum = 1;
  }

  void addNotification(Room roomInfo) {
    notificationMap[roomInfo.roomId] = roomInfo;
    FlutterNotification.showNotificationAtTime(
        keyNum, roomInfo.roomTitle, roomInfo.meetDate, roomInfo.meetTime);
  }

  void syncNotification(Map<String, String> serverNotificationSchedule) async {
    cancelAll();
    FirebaseFirestore.instance
        .collection('chatroom')
        .where('joinMember',
            arrayContains: UserController.to.loginUser.value.memberId)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var doc in value.docs) {
          Room room = Room();
          room.roomId = doc['roomId'];
          room.roomTitle = doc['roomTitle'];
          room.meetDate = doc['meetDate'];
          room.meetTime = doc['meetTime'];
          addNotification(room);
        }
      }
    });
  }

  cancelAll() async => await FlutterLocalNotificationsPlugin().cancelAll();
}
