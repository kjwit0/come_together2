import 'package:come_together2/controller/user_controller.dart';
import 'package:come_together2/modul/friend_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/friends_controller.dart';

class FriendListView extends GetView<FriendsContoller> {
  const FriendListView({super.key});

  void _addFriend(FriendInfo value) {
    Get.find<UserController>().addFriend(value);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.friends.value.isEmpty
          ? Container(
              margin: const EdgeInsets.all(40),
              child: Text(
                '검색된 사용자가 없습니다',
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.friends.value.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Image.network(controller.friends.value[index].memberIcon),
                              const Icon(
                                Icons.account_box,
                              ),
                              Text(controller
                                  .friends.value[index].memberNickname),
                              ElevatedButton(
                                onPressed: () {
                                  _addFriend(controller.friends.value[index]);
                                },
                                child: const Text('추가하기'),
                              ),
                            ],
                          ),
                        ]),
                  ),
                );
              },
            ),
    );
  }
}
