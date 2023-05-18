import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:come_together2/controller/room_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_box.dart';

class MessageList extends StatelessWidget {
  MessageList({required this.roomId, super.key});
  late String roomId;

  @override
  Widget build(BuildContext context) {
    final loginUser = FirebaseAuth.instance.currentUser;

    return StreamBuilder(
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
                      chatData.docs[index]['text'],
                      chatData.docs[index]['memberId'] == loginUser!.uid,
                      RoomController.to
                          .getFriendInRoom(chatData.docs[index]['memberId'])
                          .memberNickname,
                      RoomController.to
                          .getFriendInRoom(chatData.docs[index]['memberId'])
                          .memberIcon);
                });
      },
    );
  }
}
