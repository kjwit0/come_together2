import 'package:come_together2/components/come_together_button.dart';
import 'package:come_together2/components/come_together_validate.dart';
import 'package:come_together2/controller/friends_controller.dart';
import 'package:come_together2/controller/general_setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});
  final TextEditingController timeContoller = TextEditingController();
  bool is_changed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: GetX<GeneralSettingController>(builder: (controller) {
          return ListView(
            padding: const EdgeInsets.all(10),
            children: [
              const Text(
                'Settings',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Divider(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.topRight,
                child: Text(
                  '마지막 동기화 시간: ${controller.config.value.lastSyncFriendsTime}',
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ComeTogetherButton(
                  onPressed: () {
                    FriendsContoller.to.syncFriends();
                    ValidateData().showToast('동기화 되었습니다.');
                  },
                  text: '친구 동기화',
                  color: Colors.blue[600],
                ),
              ),
              const Divider(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        '알림 설정 켜기 ',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Switch(
                        value: controller.config.value.isShowAlarm,
                        onChanged: (value) {
                          controller.setShowAlarm(value);
                          is_changed = true;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 20),
              controller.config.value.isShowAlarm
                  ? Column(
                      children: [
                        Container(
                          alignment: Alignment.topRight,
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            '모임 ${controller.config.value.beforeMiniute} 분 전 알람',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: 100,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    maxLength: 3,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.0)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blueAccent,
                                            width: 1.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.0)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blueAccent,
                                            width: 2.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.0)),
                                      ),
                                      counterText: '',
                                    ),
                                    controller: timeContoller,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: const Text(
                                    '분 전',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ComeTogetherButton(
                                    onPressed: () {
                                      is_changed = true;
                                      controller.setBeforeMiniute(
                                          int.parse(timeContoller.text));
                                      FocusScope.of(context).unfocus();
                                    },
                                    text: '알람 시간 설정',
                                    color: Colors.blue[600],
                                  ),
                                ),
                              ]),
                        ),
                      ],
                    )
                  : Container(),
              const Divider(height: 20),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ComeTogetherButton(
                  onPressed: () {
                    if (is_changed = true) {
                      controller.saveLocalSetting();
                      ValidateData().showToast('수정 되었습니다.');
                    }
                  },
                  text: '설정 저장',
                  color: Colors.deepPurple[400],
                ),
              ),
            ],
          );
        }),
      ),
    ));
  }
}
