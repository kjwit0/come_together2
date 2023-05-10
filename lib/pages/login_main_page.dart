import 'package:come_together2/controller/main_page_contoller.dart';
import 'package:come_together2/controller/user_controller.dart';
import 'package:come_together2/view/ct_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'chat/room/chat_room_list.dart';
import 'member/friends/friend_list.dart';
import 'member/my_page.dart';
import 'setting_page.dart';

class LoginMain extends StatelessWidget {
  LoginMain({super.key});
  List<Widget> pages = <Widget>[
    FriendList(), // 외부 클래스로 정의
    ChatRoomList(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    Get.put(MainPageContoller());
    Get.put(UserController());

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
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.black87,
              backgroundImage: null,
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const MyPage();
                  }));
                },
              ),
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
