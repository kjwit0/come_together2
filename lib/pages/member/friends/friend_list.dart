import 'package:come_together2/controller/friends_controller.dart';
import 'package:come_together2/controller/user_controller.dart';
import 'package:come_together2/pages/member/friends/add_friend.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'friend_info_card.dart';

class FriendList extends StatelessWidget {
  const FriendList({super.key});

  @override
  Widget build(BuildContext context) {
    FriendsContoller.to.syncFriends();

    return Scaffold(
      body: Column(
        children: [
          const Text('Friend List'),
          const Divider(),
          Expanded(
            child: GetX<FriendsContoller>(builder: (controller) {
              return controller.friends.isEmpty
                  ? const Text(
                      '우측하단의 + 버튼을 눌러서 친구를 추가하세요!',
                      style: TextStyle(fontSize: 18),
                    )
                  : ListView.builder(
                      itemCount: controller.friends.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child:
                              FriendInfoCard(friend: controller.friends[index]),
                        );
                      },
                    );
            }),
          ),
        ],
      ),
      floatingActionButton: UserController.to.isLogin()
          ? FloatingActionButton.extended(
              onPressed: () {
                Get.to(() => AddFriend());
              },
              label: const Text('친구추가'),
              icon: const Icon(Icons.add),
              backgroundColor: Colors.blue[300],
            )
          : null,
    );
  }
}
