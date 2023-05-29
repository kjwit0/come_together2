import 'package:come_together2/components/come_together_button.dart';
import 'package:come_together2/components/come_together_validate.dart';
import 'package:come_together2/controller/room_list_controller.dart';
import 'package:come_together2/pages/chat/room/room_invite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/user_controller.dart';
import '../../../model/room.dart';
import 'room_member_list.dart';
import '../../login_main_page.dart';
import '../message/message_list.dart';
import '../message/message_send.dart';
import 'meeting_room_setting.dart';

// ignore: must_be_immutable
class MeetingRoom extends StatelessWidget {
  MeetingRoom({required this.roomKey, super.key});
  String roomKey;

  @override
  Widget build(BuildContext context) {
    return GetX<RoomListController>(builder: (RoomListController controller) {
      controller.loadRoomMembersInfo(roomKey);
      Room roomInfo = controller.roomMap[roomKey] ?? Room();

      return Scaffold(
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
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                    (roomInfo.createMember ==
                            UserController.to.loginUser.value.memberId)
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 10, 0),
                            child: IconButton(
                              icon: const Icon(Icons.settings),
                              color: Colors.black,
                              onPressed: () {
                                Get.to(() => const MeetingRoomSetting(),
                                    arguments: roomKey);
                              },
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              const Divider(),
              RoomMemberList(memberList: controller.friendsMap),
              const SizedBox(height: 20),
              ComeTogetherButton(
                onPressed: () {
                  Get.to(RoomInvite(
                    roomId: roomKey,
                  ));
                },
                text: '멤버 초대하기',
                color: Colors.blue[300],
              ),
              const SizedBox(height: 20),
              ComeTogetherButton(
                onPressed: () {
                  controller.exitRoom(roomInfo.roomId);
                  ValidateData().showSnackBar('방 나가기', '퇴장 하였습니다.');
                  Get.offAll(() => LoginMain());
                },
                text: '방에서 나가기',
                color: Colors.deepOrange[300],
              )
            ],
          ),
        ),
        appBar: AppBar(
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              roomInfo.roomTitle,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '${roomInfo.meetDate} ${roomInfo.meetTime}',
              style: TextStyle(color: Colors.blue[300], fontSize: 15),
            ),
          ]),
        ),
        body: Column(
          children: [
            Expanded(
              child: MessageList(roomId: roomInfo.roomId),
            ),
            MessageSend(roomId: roomInfo.roomId),
          ],
        ),
      );
    });
  }
}
