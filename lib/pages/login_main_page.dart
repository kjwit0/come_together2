import 'package:come_together2/controller/room_list_controller.dart';
import 'package:come_together2/controller/user_controller.dart';
import 'package:come_together2/controller/general_setting_controller.dart';
import 'package:come_together2/controller/main_page_contoller.dart';
import 'package:come_together2/controller/room_controller.dart';
import 'package:come_together2/pages/first_page.dart';
import 'package:come_together2/view/ct_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    print('rebuild');

    if (UserController.to.isLogin()) {
      GeneralSettingController.to.setFirstLogin(false);
      RoomListController.to.bindRoomMapStream();
    }

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
                    backgroundColor: UserController.to.isLogin()
                        ? Colors.deepPurple[400]
                        : Colors.blue[400]),
                onPressed: () {
                  UserController.to.isLogin()
                      ? Get.to(() => const MyPage())
                      : Get.to(() => const FirstPage());
                },
                icon: Icon(
                  UserController.to.isLogin()
                      ? Icons.account_box_rounded
                      : Icons.login,
                  color: Colors.black87,
                ),
                label: Text(
                  UserController.to.isLogin() ? 'MyPage' : 'LogIn',
                  style: const TextStyle(
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
      floatingActionButton: UserController.to.isLogin()
          ? Container()
          : TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () {},
              child: const Text('Network Disconnected')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
    );
  }
}
