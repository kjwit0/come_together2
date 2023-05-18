import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateTimeController extends GetxController {
  static DateTimeController get to => Get.find();
  final Rx<String> date = RxString('');
  final Rx<String> time = RxString('');

  void showDatePickerPop(BuildContext context) async {
    Future<DateTime?> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(), //초기값
      firstDate: DateTime.now(), //시작일
      lastDate: DateTime.now().add(const Duration(days: 60)), //마지막일
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(), //다크 테마
          child: child!,
        );
      },
    );
    DateTime? dateTime = await selectedDate;

    if (dateTime != null) {
      date.value = DateFormat('y-M-d').format(dateTime);
    }
  }

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

  void clearDateTimeInfo() {
    time.value = '';
    date.value = '';
  }
}
