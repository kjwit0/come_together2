import 'package:come_together2/components/come_together_themes.dart';
import 'package:come_together2/controller/auth_controller.dart';
import 'package:come_together2/controller/general_setting_controller.dart';
import 'package:come_together2/model/friend_info.dart';
import 'package:come_together2/model/notification.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'controller/friends_controller.dart';
import 'controller/room_list_controller.dart';
import 'firebase_options.dart';
import 'model/come_together_config.dart';
import 'model/room.dart';
import 'pages/first_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //알람 설정 초기화
  FlutterNotification.init();

  //local database
  await Hive.initFlutter();

  Hive.registerAdapter(FriendInfoAdapter());
  Hive.registerAdapter(ComeTogetherConfigAdapter());
  Hive.registerAdapter(RoomAdapter());

  await Hive.openBox<FriendInfo>('friendsBox').then((value) {
    Get.put(FriendsContoller());
  });

  await Hive.openBox<ComeTogetherConfig>('comeTogetherConfig').then((value) {
    Get.put(GeneralSettingController());
  });

  await Hive.openBox<Room>('roomBox').then((value) {
    Get.put(RoomListController()).loadLocalRooms();
  });

  // Hive.deleteBoxFromDisk('roomBox');
  //Hive.box<Room>('roomBox').deleteBoxFromDisk();
  //Hive.box<ComeTogetherConfig>('comeTogetherConfig').deleteFromDisk();
  // Hive.box<FriendInfo>('friendsBox').deleteFromDisk();

  //firebase 플러그인
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ).then((value) {
      Get.put(AuthController());
    });

    await FirebaseAppCheck.instance.activate(
      webRecaptchaSiteKey: 'recaptcha-v3-site-key',
    );
  } on FirebaseAuthException catch (e) {
    print(e);
  }

  //앱 실행
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNotification.requestNotificationPermission();
    FriendsContoller.to.loadLocalFriends();

    return GetMaterialApp(
      title: 'Come Tegether',
      theme: CometogetherTheme.darkTheme,
      home: const FirstPage(),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: child!,
      ),
    );
  }
}
