import 'package:come_together2/components/come_together_validate.dart';
import 'package:come_together2/controller/date_time_controller.dart';
import 'package:come_together2/controller/room_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/come_together_button.dart';
import '../../../view/select_date_time.dart';

class MeetingRoomAdd extends StatelessWidget {
  const MeetingRoomAdd({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RoomController());
    Get.put(DateTimeController());

    return Scaffold(
      appBar: AppBar(title: const Text('모집글 등록')),
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
                    maxLength: 35,
                    onChanged: (value) =>
                        {RoomController.to.room.value.roomTitle = value},
                    decoration: const InputDecoration(
                      hintText: '모집글의 제목을 입력해주세요.',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const SelectDateTime(),
            const SizedBox(height: 40),
            ComeTogetherButton(
              text: '모집글 등록',
              onPressed: () {
                if (RoomController.to.createRoom()) {
                  ValidateData().showToast('등록 되었습니다');
                  RoomController.to.clearRoomInfo();
                  DateTimeController.to.clearDateTimeInfo();
                  Get.back();
                }
              },
            ),
          ]),
        ),
      ),
    );
  }
}
