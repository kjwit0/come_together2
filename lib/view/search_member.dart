import 'dart:async';

import 'package:come_together2/controller/user_controller.dart';
import 'package:come_together2/view/userIcon_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/come_together_validate.dart';
import '../controller/friends_controller.dart';
import '../pages/login_main_page.dart';

class FriendListView extends GetView<FriendsContoller> {
  const FriendListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.searchedFriend.value.memberId == ''
          ? Container(
              margin: const EdgeInsets.all(40),
              child: const Text(
                '검색된 사용자가 없습니다',
                style: TextStyle(fontSize: 20),
              ),
            )
          : Card(
              margin: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          UserIconView(
                              url: controller.searchedFriend.value.memberIcon),
                          Text(controller.searchedFriend.value.memberNickname),
                          ElevatedButton(
                            onPressed: () {
                              Get.find<UserController>().addFriends(
                                  controller.searchedFriend.value.memberId);

                              Get.find<UserController>().updateFriends();

                              ValidataData().showToast('추가 되었습니다.');
                              Get.off(() => LoginMain());
                            },
                            child: const Text('추가하기'),
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
    );
  }
}
