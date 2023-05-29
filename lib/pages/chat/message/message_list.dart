import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:come_together2/controller/room_list_controller.dart';
import 'package:flutter/material.dart';
import '../../../controller/user_controller.dart';
import 'message_box.dart';

// ignore: must_be_immutable
class MessageList extends StatelessWidget {
  MessageList({required this.roomId, super.key});
  String roomId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .where('roomId', isEqualTo: roomId)
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          QuerySnapshot<Map<String, dynamic>>? chatData = snapshot.data;

          return chatData == null
              ? const Text('data')
              : ListView.builder(
                  reverse: true,
                  itemCount: chatData.docs.length,
                  itemBuilder: (context, index) {
                    return MessageBox(
                      nickname: RoomListController
                          .to
                          .friendsMap[chatData.docs[index]['memberId']]!
                          .memberNickname,
                      message: chatData.docs[index]['text'],
                      userIcon: RoomListController
                          .to
                          .friendsMap[chatData.docs[index]['memberId']]!
                          .memberIcon,
                      isMe: chatData.docs[index]['memberId'] ==
                          UserController.to.loginUser.value.memberId,
                    );
                  });
        },
      ),
    );
  }
}
