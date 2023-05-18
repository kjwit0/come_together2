import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:come_together2/controller/room_controller.dart';
import 'package:come_together2/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'metting_room.dart';
import 'metting_room_add.dart';

class MeetingRoomList extends StatelessWidget {
  const MeetingRoomList({super.key});

  String formatTimestamp(Timestamp timestamp) {
    var format = DateFormat('y-M-d 일 H 시 m 분');
    return format.format(timestamp.toDate());
  }

  @override
  Widget build(BuildContext context) {
    Get.put(RoomController());

    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chatroom')
            .where('joinMember',
                isGreaterThanOrEqualTo:
                    Get.find<UserController>().loginUser.value.memberId)
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
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.all(5),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => const MeetingRoom(),
                              arguments:
                                  snapshot.data!.docs[index].data()['roomId']);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(snapshot.data!.docs[index]['roomTitle'],
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  '모임 시간 : ${snapshot.data!.docs[index]['meetDate']}   ${snapshot.data!.docs[index]['meetTime']}',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.blue[700]))
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
          Get.to(() => const MeetingRoomAdd());
        },
        label: const Text('모집글 등록'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.blue[300],
      ),
    );
  }
}
