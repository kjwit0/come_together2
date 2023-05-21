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

    //받아온 String으로 시간 설정
    List<String> meetDateSplit = meetDate.split('-');
    List<String> meetTimeSplit = meetTime.split(':');
    // 인자 tz.lacal, now.year, now.month, now.day, hour, min, sec

    var time = tz.TZDateTime(
        tz.local,
        int.parse(meetDateSplit[0]),
        int.parse(meetDateSplit[1]),
        int.parse(meetDateSplit[2]),
        int.parse(meetTimeSplit[0]),
        int.parse(meetTimeSplit[1]),
        00);

    if (time.isAfter(tz.TZDateTime.now(tz.local))) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          title,
          '모임 시간 입니다.',
          time,
          // 알림일자 세팅
          notificationDetails,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    }
  }

  void deleteNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  void syncNotification() {
    //todo: server , local notification sync
  }
}
