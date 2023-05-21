import 'package:come_together2/components/come_together_validate.dart';
import 'package:come_together2/controller/friends_controller.dart';
import 'package:come_together2/controller/room_controller.dart';
import 'package:come_together2/pages/member/friends/add_friend.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/come_together_user_icon.dart';

class RoomInvite extends StatelessWidget {
  const RoomInvite({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('초대하기')),
        body: Column(
          children: [
            const Text('Friend List'),
            const Divider(),
            Expanded(
              child: GetX<FriendsContoller>(builder: (controller) {
                return controller.friends.isEmpty
                    ? const Text(
                        '초대할 친구가 없습니다.',
                        style: TextStyle(fontSize: 18),
                      )
                    : ListView.builder(
                        itemCount: controller.friends.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: const EdgeInsets.fromLTRB(30, 5, 30, 0),
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
                                        ElevatedButton(
                                          onPressed: () {
                                            RoomController.to.addRoomMember(
                                                controller
                                                    .friends[index].memberId);
                                            ValidateData()
                                                .showToast('초대 되었습니다.');
                                            Get.back();
                                          },
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
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
      ),
    );
  }
}
