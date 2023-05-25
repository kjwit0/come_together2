// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// 알람 설정 관련 클래스
class FlutterNotification {
  FlutterNotification._();

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static init() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('mipmap/ic_launcher');

    DarwinInitializationSettings iosInitializationSettings =
        const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static requestNotificationPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  /// 특정 날짜 및 시간에 알람을 발생
  static Future<void> showNotificationAtTime(
      int id, String title, String meetDate, String meetTime) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel id', 'channel name',
            channelDescription: 'channelDescription',
            importance: Importance.max,
            priority: Priority.max,
            showWhen: false);
    const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: DarwinNotificationDetails(badgeNumber: 1));

    //5 분전 알람
    DateTime meetDateTime = DateFormat("yyyy-MM-dd hh:mm:ss")
        .parse('$meetDate $meetTime:00')
        .subtract(const Duration(minutes: 5));
    print(meetDateTime);

    // 인자 tz.lacal, now.year, now.month, now.day, hour, min, sec
    tz.initializeTimeZones();

    var time = tz.TZDateTime(tz.local, meetDateTime.year, meetDateTime.month,
        meetDateTime.day, meetDateTime.hour, meetDateTime.minute, 00);

    if (time.isAfter(tz.TZDateTime.now(tz.local))) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          title,
          '곧 모임 시간 입니다.',
          time,
          // 알림일자 세팅
          notificationDetails,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    }
  }

  /// 알람 취소
  void deleteNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  /// 알람을 로컬과 서버 동기화
  void syncNotification() {
    //todo: server , local notification sync
  }
}
