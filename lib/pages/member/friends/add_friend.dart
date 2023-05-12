import 'dart:async';

import 'package:come_together2/view/search_member.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/friends_controller.dart';

class AddFriend extends StatelessWidget {
  AddFriend({super.key});
  final TextEditingController friendSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Get.put(FriendsContoller());
    return Scaffold(
      appBar: AppBar(title: const Text('친구추가하기')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    maxLength: 35,
                    controller: friendSearchController,
                    decoration: InputDecoration(
                        hintText: '  친구의 이메일을 입력하세요',
                        suffixIcon: IconButton(
                          onPressed: () {
                            friendSearchController.clear();
                          },
                          icon: const Icon(Icons.clear),
                        )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  color: Colors.green[300],
                  onPressed: () {
                    Timer(const Duration(milliseconds: 700), () {
                      Get.find<FriendsContoller>().searchMemberByEmail(
                          friendSearchController.value.text);
                    });
                  },
                  child: const Icon(Icons.search),
                ),
              ),
            ],
          ),
          const FriendListView(),
        ],
      ),
    );
  }
}
