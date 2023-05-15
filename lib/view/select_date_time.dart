import 'package:come_together2/controller/room_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/come_together_button.dart';

class SelectDateTime extends GetView<RoomController> {
  const SelectDateTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ComeTogetherButton(
                  text: '날짜 선택',
                  color: Colors.blueGrey[300],
                  onPressed: () => controller.showDatePickerPop(context),
                ),
                ComeTogetherButton(
                  text: '시간 설정',
                  color: Colors.blueGrey[300],
                  onPressed: () => controller.showTimePickerPop(context),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(width: 50),
                controller.room.value.meetDate.isEmpty
                    ? const Text(' ')
                    : Text('날짜:  ${controller.room.value.meetDate}',
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white)),
                const SizedBox(width: 20),
                controller.room.value.meetTime.isEmpty
                    ? const Text('')
                    : Text('시간: ${controller.room.value.meetTime}',
                        style: TextStyle(
                            fontSize: 20, color: Colors.amberAccent[100])),
              ],
            )
          ],
        ));
  }
}
