import 'package:come_together2/components/come_together_button.dart';
import 'package:come_together2/controller/room_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../view/room_member_list.dart';
import '../message/message_list.dart';
import '../message/message_send.dart';

class ChatRoom extends StatelessWidget {
  const ChatRoom({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RoomController()).initRoom(Get.arguments);
    RoomController.to.getRoomMembersInfo();
    return Scaffold(
        endDrawer: Drawer(
          child: ListView(
            children: [
              Container(
                color: Colors.green[300],
                padding: const EdgeInsets.all(10),
                child: Text(
                  '참여멤버',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              Divider(),
              RoomMemberList(),
              SizedBox(height: 30),
              ComeTogetherButton(
                onPressed: () {},
                text: '방에서 나가기',
                color: Colors.blue[300],
              )
            ],
          ),
        ),
        appBar: AppBar(
            title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              RoomController.to.room.value.roomTitle,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '${RoomController.to.room.value.meetDate} ${RoomController.to.room.value.meetTime}',
              style: TextStyle(color: Colors.blue[300], fontSize: 15),
            ),
          ],
        )),
        body: Column(
          children: [
            Expanded(
              child: MessageList(
                roomId: RoomController.to.room.value.roomId,
              ),
            ),
            MessageSend(roomId: RoomController.to.room.value.roomId),
          ],
        ));
  }
}
