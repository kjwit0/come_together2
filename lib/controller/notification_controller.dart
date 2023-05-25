import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../model/notification.dart';
import '../model/room.dart';

class NotificationController {
  NotificationController._();
  static final NotificationController _instance = NotificationController._();

  factory NotificationController() {
    return _instance;
  }

  /// 알람 설정 추가
  void addNotification(Room roomInfo) {
    FlutterNotification.showNotificationAtTime(roomInfo.notificationId,
        roomInfo.roomTitle, roomInfo.meetDate, roomInfo.meetTime);
  }

  /// 기존의 알람 설정 수정
  void updateNotification(Room roomInfo) {
    cancelAt(roomInfo.notificationId);
    FlutterNotification.showNotificationAtTime(roomInfo.notificationId,
        roomInfo.roomTitle, roomInfo.meetDate, roomInfo.meetTime);
  }

  /// 기존의 알람 설정을 모두 취소
  void cancelAll() async {
    await FlutterLocalNotificationsPlugin().cancelAll();
  }

  /// 특정 알람 취소
  void cancelAt(int notificationId) async {
    await FlutterLocalNotificationsPlugin().cancel(notificationId);
  }
}
