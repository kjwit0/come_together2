import 'package:come_together2/components/come_together_button.dart';
import 'package:come_together2/components/come_together_validate.dart';
import 'package:come_together2/controller/friends_controller.dart';
import 'package:come_together2/controller/general_setting_controller.dart';
import 'package:come_together2/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});
  // final TextEditingController timeContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          const Text(
            'Settings',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(height: 20),
          GetX<GeneralSettingController>(builder: (controller) {
            return Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.topRight,
              child: Text(
                '마지막 동기화 시간: ${controller.config.value.lastSyncFriendsTime}',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ComeTogetherButton(
              onPressed: () {
                FriendsContoller.to.synchronizeLocalFriend();
                ValidateData().showToast('동기화 되었습니다.');
              },
              text: '친구 동기화',
              color: Colors.blue[300],
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: Text(
              '모임 ${GeneralSettingController.to.config.value.beforeMiniute} 분 전 알람',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
                width: 100,
                child: TextFormField(
                  keyboardType: TextInputType.number,

                  maxLength: 3,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                  ),
                  // controller: timeContoller,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ComeTogetherButton(
                  onPressed: () {},
                  text: '알람 시간 설정',
                  color: Colors.blue[300],
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
