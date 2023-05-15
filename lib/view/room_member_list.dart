import 'package:come_together2/controller/friends_controller.dart';
import 'package:come_together2/controller/room_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/friend_info.dart';
import 'userIcon_view.dart';

class RoomMemberList extends GetView<RoomController> {
  const RoomMemberList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          height: (MediaQuery.of(context).size.height) * 2 / 3,
          child: ListView.builder(
              itemCount: RoomController.to.room.value.joinMember.length,
              itemBuilder: (context, index) {
                return Card(
                    margin: const EdgeInsets.all(10),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            UserIconView(
                              url: RoomController
                                  .to.roomMembers[index].memberIcon,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 30),
                              child: Text(RoomController
                                  .to.roomMembers[index].memberNickname),
                            ),
                          ]),
                    ));
              }),
        ));
  }
}
