import 'package:come_together2/components/come_together_themes.dart';
import 'package:come_together2/controller/auth_controller.dart';
import 'package:come_together2/controller/general_setting_controller.dart';
import 'package:come_together2/controller/user_controller.dart';
import 'package:come_together2/model/friend_info.dart';
import 'package:come_together2/model/notification.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'controller/friends_controller.dart';
import 'firebase_options.dart';
import 'pages/first_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNotification.init();

  //local database
  await Hive.initFlutter();
  Hive.registerAdapter(FriendInfoAdapter());

  await Hive.openBox<FriendInfo>('friendsBox').then((value) {
    Get.put(FriendsContoller());
  });
  // Hive.box<FriendInfo>('friendsBox').deleteFromDisk();
  //firebase 플러그인
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    Get.put(AuthController());
  });

  Get.put(GeneralSettingController());

  //await Hive.openBox('comeTogetherConfig').then((value){
  // if(value.values[0].isFirstRun == true){
  // FriendsContoller.synchronizeLocalFriend();
  // }
  //});

  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNotification.requestNotificationPermission();
    Get.put(UserController());
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
