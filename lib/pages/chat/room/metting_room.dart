import 'package:come_together2/components/come_together_button.dart';
import 'package:come_together2/components/come_together_validate.dart';
import 'package:come_together2/controller/room_controller.dart';
import 'package:come_together2/controller/user_controller.dart';
import 'package:come_together2/pages/chat/room/room_invite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'room_member_list.dart';
import '../../login_main_page.dart';
import '../message/message_list.dart';
import '../message/message_send.dart';
import 'meeting_room_setting.dart';

class MeetingRoom extends StatelessWidget {
  const MeetingRoom({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RoomController()).bindStream(Get.arguments);

    return GetX<RoomController>(builder: (RoomController controller) {
      controller.loadRoomMembersInfo();
      return controller.room.value.roomId == ''
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              endDrawer: Drawer(
                child: ListView(
                  children: [
                    Container(
                      color: Colors.green[300],
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              '참여멤버',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                          (controller.room.value.createMember ==
                                  UserController.to.loginUser.value.memberId)
                              ? Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 10, 0),
                                  child: IconButton(
                                    icon: const Icon(Icons.settings),
                                    color: Colors.black,
                                    onPressed: () {
                                      Get.to(() => const MeetingRoomSetting());
                                    },
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    const Divider(),
                    const RoomMemberList(),
                    const SizedBox(height: 20),
                    ComeTogetherButton(
                      onPressed: () {
                        Get.to(const RoomInvite());
                      },
                      text: '멤버 초대하기',
                      color: Colors.blue[300],
                    ),
                    const SizedBox(height: 20),
                    ComeTogetherButton(
                      onPressed: () {
                        controller.exitRoom();
                        ValidateData().showToast('퇴장 하였습니다.');
                        Get.off(() => LoginMain());
                      },
                      text: '방에서 나가기',
                      color: Colors.deepOrange[300],
                    )
                  ],
                ),
              ),
              appBar: AppBar(
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.room.value.roomTitle,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${controller.room.value.meetDate} ${controller.room.value.meetTime}',
                        style: TextStyle(color: Colors.blue[300], fontSize: 15),
                      ),
                    ]),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: MessageList(
                      roomId: controller.room.value.roomId,
                    ),
                  ),
                  MessageSend(roomId: controller.room.value.roomId),
                ],
              ),
            );
    });
  }
}
