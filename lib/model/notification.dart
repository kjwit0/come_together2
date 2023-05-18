import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

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

  // static Future<void> showNotification(String text) async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails('channel id', 'channel name',
  //           channelDescription: 'channelDescription',
  //           importance: Importance.max,
  //           priority: Priority.max,
  //           showWhen: false);
  //   const NotificationDetails notificationDetails = NotificationDetails(
  //       android: androidNotificationDetails,
  //       iOS: DarwinNotificationDetails(badgeNumber: 1));

  //   await flutterLocalNotificationsPlugin.show(
  //       0, 'ComeTogether', text, notificationDetails);
  // }

  static Future<void> showNotificationAtTime(
      int id, String title, String meetTime) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel id', 'channel name',
            channelDescription: 'channelDescription',
            importance: Importance.max,
            priority: Priority.max,
            showWhen: false);
    const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: DarwinNotificationDetails(badgeNumber: 1));

    //받아온 String으로 시간 설정
    var time = tz.TZDateTime(tz.local, 1, 2, 3, 4, 5, 6);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        '모임 시간 입니다.',
        time.isBefore(tz.TZDateTime.now(tz.local))
            ? time.add(Duration(days: 1))
            : time,
        // 알림일자 세팅
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
