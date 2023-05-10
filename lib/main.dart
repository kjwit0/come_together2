import 'package:come_together2/components/come_together_themes.dart';
import 'package:come_together2/controller/auth_controller.dart';
import 'package:come_together2/controller/user_controller.dart';
import 'package:come_together2/modul/friend_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'firebase_options.dart';
import 'pages/first_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //local database
  await Hive.initFlutter();
  Hive.registerAdapter(FriendInfoAdapter());
  await Hive.openBox('member');
  await Hive.openBox<FriendInfo>('friendInfoBox');

  //firebase 플러그인
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthController()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
