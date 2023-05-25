import 'package:come_together2/components/come_together_button.dart';
import 'package:come_together2/components/come_together_validate.dart';
import 'package:come_together2/controller/friends_controller.dart';
import 'package:come_together2/controller/general_setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: GetX<GeneralSettingController>(builder: (controller) {
          bool isChanged = false;
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
              Column(
                children: [
                  Row(
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
                            isChanged = true;
                          },
                        ),
                      ),
                    ],
                  ),
                  controller.config.value.isShowAlarm
                      ? Container(
                          padding: const EdgeInsets.only(right: 20),
                          alignment: Alignment.topRight,
                          child: Text(
                            '모임 5 분 전 알람 표시',
                            style: TextStyle(
                                fontSize: 15, color: Colors.blue[400]),
                          ),
                        )
                      : const SizedBox(height: 22),
                ],
              ),
              const Divider(height: 20),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ComeTogetherButton(
                  onPressed: () {
                    if (isChanged == true) {
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
