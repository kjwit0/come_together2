import 'package:come_together2/controller/main_page_contoller.dart';
import 'package:come_together2/controller/room_controller.dart';
import 'package:come_together2/view/ct_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/user_controller.dart';
import 'chat/room/metting_room_list.dart';
import 'member/friends/friend_list.dart';
import 'member/my_page.dart';
import 'setting_page.dart';

// ignore: must_be_immutable
class LoginMain extends StatelessWidget {
  LoginMain({super.key});

  List<Widget> pages = <Widget>[
    const FriendList(),
    const MeetingRoomList(),
    const SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    Get.put(MainPageContoller());
    Get.put(UserController());
    Get.put(RoomController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'COME TOGETHER',
          style: TextStyle(
            color: Colors.green[300],
          ),
        ),
        actions: [
          Container(
              padding: const EdgeInsets.fromLTRB(0, 7, 20, 7),
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.deepPurple[400]),
                onPressed: () {
                  Get.to(() => const MyPage());
                },
                icon: const Icon(
                  Icons.account_box_rounded,
                  color: Colors.black87,
                ),
                label: const Text(
                  'MyPage',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                ),
              )),
        ],
      ),
      body: Obx(() => SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: pages[MainPageContoller.to.selectedIndex.value],
          ))),
      bottomNavigationBar: const CTBottomNavgationBar(),
    );
  }
}
