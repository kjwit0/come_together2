import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:come_together2/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'chat_room.dart';
import 'chat_room_add.dart';

class ChatRoomList extends StatelessWidget {
  const ChatRoomList({super.key});

  String formatTimestamp(Timestamp timestamp) {
    var format = DateFormat('y-M-d 일 H 시 m 분');
    return format.format(timestamp.toDate());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chatroom')
            .where('joinMember',
                isGreaterThanOrEqualTo:
                    Get.find<UserController>().loginUser.value.memberId)
            .orderBy('joinMember', descending: true)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return (snapshot.data == null)
              ? const Center(child: Text('현재 참여 중인 방이 없습니다.'))
              : ListView.builder(
                  //reverse: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.all(5),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => ChatRoom(
                                roomTitle: snapshot.data!.docs[index]['title'],
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(snapshot.data!.docs[index]['title'],
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  '${snapshot.data!.docs[index]['createMember']} // ${snapshot.data!.docs[index]['joinMember']} ',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.blue[700])),
                              Text(
                                  formatTimestamp(
                                      snapshot.data!.docs[index]['time']),
                                  style: const TextStyle(
                                      fontSize: 17, color: Colors.red))
                            ],
                          ),
                        ),
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
        label: const Text('모집글 등록'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.blue[300],
      ),
    );
  }
}
