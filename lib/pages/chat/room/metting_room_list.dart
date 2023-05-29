import 'package:come_together2/components/come_together_validate.dart';
import 'package:come_together2/controller/room_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/user_controller.dart';
import 'metting_room.dart';
import 'metting_room_add.dart';

class MeetingRoomList extends StatelessWidget {
  const MeetingRoomList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<RoomListController>(builder: (controller) {
        return (controller.roomMap.isEmpty)
            ? const Center(child: Text('현재 참여 중인 방이 없습니다.'))
            : ListView.builder(
                itemCount: controller.roomMap.length,
                itemBuilder: (context, index) {
                  String roomKey = controller.roomMap.keys.elementAt(index);
                  return Card(
                    margin: const EdgeInsets.all(5),
                    child: InkWell(
                      onTap: () {
                        UserController.to.isLogin()
                            ? Get.to(() => MeetingRoom(roomKey: roomKey))
                            : ValidateData()
                                .showSnackBar('offline', '오프라인 상태입니다.');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(controller.roomMap[roomKey]!.roomTitle,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Text(
                                '${controller.roomMap[roomKey]!.meetDate}   ${controller.roomMap[roomKey]!.meetTime}',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.blue[700]))
                          ],
                        ),
                      ),
                    ),
                  );
                });
      }),
      floatingActionButton: UserController.to.isLogin()
          ? FloatingActionButton.extended(
              onPressed: () {
                Get.to(() => const MeetingRoomAdd());
              },
              label: const Text('모집글 등록'),
              icon: const Icon(Icons.add),
              backgroundColor: Colors.blue[300],
            )
          : null,
    );
  }
}
