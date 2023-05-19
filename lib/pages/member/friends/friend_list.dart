import 'package:come_together2/controller/friends_controller.dart';
import 'package:come_together2/pages/member/friends/add_friend.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../view/user_icon_view.dart';

class FriendList extends StatelessWidget {
  const FriendList({super.key});

  @override
  Widget build(BuildContext context) {
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
                          child: Card(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: UserIconView(
                                              url: controller
                                                  .friends[index].memberIcon),
                                        ),
                                        Text(
                                          controller
                                              .friends[index].memberNickname,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              child: const Icon(
                                                Icons.call,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.red),
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        barrierDismissible:
                                                            true, // 바깥 영역 터치시 닫을지 여부
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                              content: Text(
                                                                '${controller.friends[index].memberNickname} 님을 친구에서 제거합니다.',
                                                              ),
                                                              insetPadding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      0,
                                                                      80,
                                                                      0,
                                                                      80),
                                                              actions: [
                                                                TextButton(
                                                                    child:
                                                                        const Text(
                                                                      '제거',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.red),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      controller
                                                                          .deleteFriend(
                                                                              controller.friends[index]);
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    }),
                                                                TextButton(
                                                                    child:
                                                                        const Text(
                                                                      '취소',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.blue),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    }),
                                                              ]);
                                                        });
                                                  },
                                                  child: const Icon(
                                                    Icons
                                                        .person_remove_outlined,
                                                    color: Colors.black54,
                                                  ))),
                                        ]),
                                      ],
                                    ),
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
        label: const Text('친구추가'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.blue[300],
      ),
    );
  }
}
