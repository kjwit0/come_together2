import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'chat_room.dart';
import 'chat_room_add.dart';

class ChatRoomList extends StatelessWidget {
  ChatRoomList({super.key});

  String? loginUserIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chatroom')
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final chatDocs = snapshot.data!.docs;

          return ListView.builder(
              //reverse: true,
              itemCount: chatDocs.length,
              itemBuilder: (context, index) {
                return const Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text('sds'),
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const ChatRoomAdd();
          }));
        },
        label: const Text('모집글 등록하기'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.green[300],
      ),
    );
  }
}
