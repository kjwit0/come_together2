import 'package:come_together2/pages/member/friends/add_friend.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/user_controller.dart';

class FriendList extends StatelessWidget {
  const FriendList({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GetX<UserController>(builder: (controller) {
              return (controller.loginUser.value.friends == null)
                  ? const Text(
                      '우측하단의 + 버튼을 눌러서 친구를 추가하세요!',
                      style: TextStyle(fontSize: 18),
                    )
                  : ListView.builder(
                      itemCount: controller.loginUser.value.friends!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.all(5),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Icon(
                                        Icons.account_box,
                                      ),
                                      Text(controller.loginUser.value
                                          .friends![index].memberNickname),
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: const Text('대화하기'),
                                      ),
                                    ],
                                  ),
                                ]),
                          ),
                        );
                      },
                    );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => AddFriend());
        },
        label: const Text('친구추가하기'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.green[300],
      ),
    );
  }
}
