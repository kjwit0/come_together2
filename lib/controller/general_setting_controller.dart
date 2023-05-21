import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../model/come_together_config.dart';

class GeneralSettingController extends GetxController {
  static GeneralSettingController get to => Get.find();
  final config = ComeTogetherConfig().obs;
  @override
  onInit() {
    super.onInit();
    loadLocalSetting();
  }

  void loadLocalSetting() async {}

  void saveLocalSetting() {
    Hive.box<ComeTogetherConfig>('comeTogetherConfig')
        .put('config', config.value);
  }

  void setBeforeMiniute(int miniute) {
    GeneralSettingController.to.config.value.beforeMiniute = miniute;
    GeneralSettingController.to.config.refresh();
  }

  void updateSyncTime(String time) {
    GeneralSettingController.to.config.value.lastSyncFriendsTime = time;
    GeneralSettingController.to.config.refresh();
  }

  void setShowAlarm(bool isShowAlarm) {
    GeneralSettingController.to.config.value.isShowAlarm = isShowAlarm;
    GeneralSettingController.to.config.refresh();
  }
}
