import 'package:come_together2/controller/date_time_controller.dart';
import 'package:come_together2/controller/room_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/come_together_button.dart';
import '../../../view/select_date_time.dart';

class MeetingRoomSetting extends StatelessWidget {
  const MeetingRoomSetting({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DateTimeController());
    TextEditingController roomTitleController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('방설정')),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: ListView(children: [
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  '제목 : ',
                  style: TextStyle(fontSize: 20),
                ),
                Expanded(
                  child: TextFormField(
                    controller: roomTitleController,
                    maxLength: 35,
                    decoration: const InputDecoration(
                      hintText: '변경할 제목을 입력해주세요.',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const SelectDateTime(),
            const SizedBox(height: 40),
            ComeTogetherButton(
              text: '모집글 수정',
              onPressed: () {
                RoomController.to.updateRoom(roomTitleController.text);
              },
            ),
          ]),
        ),
      ),
    );
  }
}
