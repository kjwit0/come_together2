import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../model/come_together_config.dart';

/// app의 일반적인 설정 파일 관리
class GeneralSettingController extends GetxController {
  static GeneralSettingController get to => Get.find();
  final config = ComeTogetherConfig().obs;

  @override
  void onInit() {
    loadLocalSetting();
    super.onInit();
  }

  /// 로컬에서 저장된 설정 로드
  void loadLocalSetting() {
    config.value =
        Hive.box<ComeTogetherConfig>('comeTogetherConfig').values.first;
  }

  /// 로컬에 설정 저장
  void saveLocalSetting() {
    Hive.box<ComeTogetherConfig>('comeTogetherConfig')
        .put('config', config.value);
  }

  //
  // void setBeforeMiniute(int miniute) {
  //   GeneralSettingController.to.config.value.beforeMiniute = miniute;
  //   GeneralSettingController.to.config.refresh();
  // }

  /// 설정에 동기화 시간 set
  void updateSyncTime(String time) {
    GeneralSettingController.to.config.value.lastSyncFriendsTime = time;
    GeneralSettingController.to.config.refresh();
  }

  /// 설정에 알림 표시 여부 set
  void setShowAlarm(bool isShowAlarm) {
    GeneralSettingController.to.config.value.isShowAlarm = isShowAlarm;
    GeneralSettingController.to.config.refresh();
  }
}
