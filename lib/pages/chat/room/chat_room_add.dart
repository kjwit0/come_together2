import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../components/come_together_button.dart';
import '../../../components/come_together_general.dart';

class ChatRoomAdd extends StatefulWidget {
  const ChatRoomAdd({super.key});

  @override
  State<ChatRoomAdd> createState() => _ChatRoomAddState();
}

class _ChatRoomAddState extends State<ChatRoomAdd> {
  final _addRoomKey = GlobalKey<FormState>();
  String? reservedDate;
  String? reservedTime;

  late String roomTitle;

  bool _tryValidation() {
    final isValid = _addRoomKey.currentState!.validate();
    if (isValid) {
      _addRoomKey.currentState!.save();
    }
    return true;
  }

  void showDatePickerPop() {
    Future<DateTime?> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(), //초기값
      firstDate: DateTime(2020), //시작일
      lastDate: DateTime.now().add(const Duration(days: 60)), //마지막일
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(), //다크 테마
          child: child!,
        );
      },
    );

    selectedDate.then((dateTime) {
      if (dateTime != null) {
        setState(() {
          reservedDate = DateFormat('yy 년 MM 월 dd 일').format(dateTime);
        });
      }
    });
  }

  /* TimePicker 띄우기 */
  void showTimePickerPop() {
    Future<TimeOfDay?> selectedTime = showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    selectedTime.then((timeOfDay) {
      if (timeOfDay != null) {
        setState(() {
          reservedTime = '${timeOfDay.hour} : ${timeOfDay.minute}';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('모집글 등록')),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _addRoomKey,
            child: ListView(children: [
              const SizedBox(height: 20),
              UserInfoInputForm(
                  keyIndex: 1,
                  minLength: 4,
                  maxLength: 35,
                  dataValue: (value) => {roomTitle = value},
                  columText: '제목 :  ',
                  textHint: ' 모집글의 제목을 입력하세요',
                  validatorText: '4 글자 이상 입력해주세요'),
              const SizedBox(height: 30),
              ComeTogetherButton(
                text: '날짜 선택',
                color: Colors.blueGrey[300],
                onPressed: () => showDatePickerPop(),
              ),
              const SizedBox(height: 20),
              ComeTogetherButton(
                text: '시간 설정',
                color: Colors.blueGrey[300],
                onPressed: () => showTimePickerPop(),
              ),
              const SizedBox(height: 30),
              if (reservedDate != null && reservedTime != null)
                Center(
                    child: Text('$reservedDate   $reservedTime',
                        style: const TextStyle(fontSize: 20))),
              const SizedBox(height: 40),
              ComeTogetherButton(
                text: '모집글 등록',
                onPressed: () async {
                  if (_tryValidation()) {}
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
