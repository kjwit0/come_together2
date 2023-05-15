import 'package:come_together2/controller/main_page_contoller.dart';
import 'package:come_together2/controller/user_controller.dart';
import 'package:come_together2/view/ct_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/friends_controller.dart';
import 'chat/room/chat_room_list.dart';
import 'member/friends/friend_list.dart';
import 'member/my_page.dart';
import 'setting_page.dart';

class LoginMain extends StatelessWidget {
  LoginMain({super.key});

  List<Widget> pages = <Widget>[
    const FriendList(),
    const ChatRoomList(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    Get.put(MainPageContoller());
    // Get.put(UserController());

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
            margin: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 20, 5),
                child: Row(children: [
                  Icon(
                    Icons.account_box_rounded,
                    color: Colors.blue[300],
                  ),
                  Text(
                    '  MyPage',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue[300],
                        fontWeight: FontWeight.bold),
                  ),
                ]),
              ),
              onTap: () {
                Get.to(() => const MyPage());
              },
            ),
          ),
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
