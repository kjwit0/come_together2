import 'package:flutter/material.dart';

import '../../../components/come_together_general.dart';

class ChatRoomAdd extends StatefulWidget {
  const ChatRoomAdd({super.key});

  @override
  State<ChatRoomAdd> createState() => _MyWidgetState();
}

enum RoomAccessRange { public, private }

class _MyWidgetState extends State<ChatRoomAdd> {
  final _addRoomKey = GlobalKey<FormState>();
  late String roomTitle;
  RoomAccessRange? _accessRange = RoomAccessRange.public;

  bool _tryValidation() {
    final isValid = _addRoomKey.currentState!.validate();
    if (isValid) {
      _addRoomKey.currentState!.save();
    }
    return true;
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
              const SizedBox(height: 20),
              // Row(
              //   children: [
              //     ListTile(
              //       title: const Text('공개글'),
              //       leading: Radio<RoomAccessRange>(
              //         value: RoomAccessRange.public,
              //         groupValue: _accessRange,
              //         onChanged: (RoomAccessRange? value) {
              //           setState(() {
              //             _accessRange = value;
              //           });
              //         },
              //       ),
              //     ),
              //     ListTile(
              //       title: const Text('비공개'),
              //       leading: Radio<RoomAccessRange>(
              //         value: RoomAccessRange.private,
              //         groupValue: _accessRange,
              //         onChanged: (RoomAccessRange? value) {
              //           setState(() {
              //             _accessRange = value;
              //           });
              //         },
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(height: 20),
              const Text('time 설정'),
              const SizedBox(height: 30),
              OutlinedButton(
                child: const Text(
                  '모집글 등록',
                  style: TextStyle(color: Colors.black),
                ),
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
