import 'package:come_together2/controller/main_page_contoller.dart';
import 'package:come_together2/controller/user_controller.dart';
import 'package:come_together2/view/ct_bottom_navbar.dart';
import 'package:come_together2/view/userIcon_view.dart';
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
    const SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    Get.put(MainPageContoller());
    Get.put(UserController());
    Get.put(FriendsContoller());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'COME TOGETHER',
          style: TextStyle(
            color: Colors.green[300],
          ),
        ),
        actions: [
          GetBuilder<UserController>(builder: ((controller) {
            return Container(
              margin: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                child: Row(children: [
                  UserIconView(url: controller.loginUser.value.memberIcon!),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(controller.loginUser.value.memberNickname),
                  )
                ]),
                onTap: () {
                  Get.to(() => const MyPage());
                },
              ),
            );
          })),
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
