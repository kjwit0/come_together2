import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateTimeController extends GetxController {
  static DateTimeController get to => Get.find();
  final Rx<String> date = RxString('');
  final Rx<String> time = RxString('');

  /// 날짜 선택 위젯
  void showDatePickerPop(BuildContext context) async {
    Future<DateTime?> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 60)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(),
          child: child!,
        );
      },
    );

    DateTime? dateTime = await selectedDate;

    if (dateTime != null) {
      date.value = DateFormat('y-M-d').format(dateTime);
    }
  }

  /// 시간 선택 위젯
  void showTimePickerPop(BuildContext context) async {
    Future<TimeOfDay?> selectedTime = showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    TimeOfDay? timeOfDay = await selectedTime;

    if (timeOfDay != null) {
      var hour = timeOfDay.hour.toString().padLeft(2, "0");
      var min = timeOfDay.minute.toString().padLeft(2, "0");
      time.value = '$hour:$min';
    }
  }

  /// 시간 및 날짜 설정 정보를 초기화
  void clearDateTimeInfo() {
    time.value = '';
    date.value = '';
  }
}
