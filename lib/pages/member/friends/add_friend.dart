import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:come_together2/modul/friend_info.dart';
import 'package:come_together2/view/friend_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/friends_controller.dart';
import '../../../controller/user_controller.dart';

class AddFriend extends StatelessWidget {
  AddFriend({super.key});
  final TextEditingController friendSearchController = TextEditingController();

  void _searchMemberByEmail() {
    Get.find<UserController>();

    if (friendSearchController.value.text == '') {
    } else {
      Future<QuerySnapshot> searchResult = FirebaseFirestore.instance
          .collection('member')
          .where("memberEmail", isEqualTo: friendSearchController.value.text)
          .get();
      searchResult.then((value) {
        if (value.size == 0) {
          Get.find<FriendsContoller>().changeFriends([]);
        } else {
          List<FriendInfo> friends = <FriendInfo>[];

          for (var data in value.docs) {
            friends.add(FriendInfo(
                memberId: data.get('memberId'),
                memberNickname: value.docs[0].get('nickname'),
                memberIcon: value.docs[0].get('userIcon')));
          }

          Get.find<FriendsContoller>().changeFriends(friends);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(FriendsContoller());
    return Scaffold(
      appBar: AppBar(),
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
                    _searchMemberByEmail();
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
