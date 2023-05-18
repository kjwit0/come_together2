import 'package:come_together2/controller/date_time_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/come_together_button.dart';

class SelectDateTime extends GetView<DateTimeController> {
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
                controller.date.value.isEmpty
                    ? const Text('')
                    : Text('날짜:  ${controller.date.value}',
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white)),
                const SizedBox(width: 20),
                controller.time.value.isEmpty
                    ? const Text('')
                    : Text('시간: ${controller.time.value}',
                        style: TextStyle(
                            fontSize: 20, color: Colors.amberAccent[100])),
              ],
            )
          ],
        ));
  }
}
