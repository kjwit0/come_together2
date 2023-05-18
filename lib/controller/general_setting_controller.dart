import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/come_together_config.dart';

class GeneralSettingController extends GetxController {
  static GeneralSettingController get to => Get.find();
  final config = ComeTogetherConfig().obs;

  void loadLocalSetting() {
    var tempConfig =
        Hive.box<ComeTogetherConfig>('ComeTogetherConfig').getAt(0);
    if (tempConfig != null) {
      GeneralSettingController.to.config.value = tempConfig;
    }
  }

  void setBeforeMiniute(int miniute) {
    GeneralSettingController.to.config.value.beforeMiniute = miniute;
    GeneralSettingController.to.config.refresh();
  }
}
