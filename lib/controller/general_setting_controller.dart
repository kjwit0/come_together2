import 'package:come_together2/components/come_together_validate.dart';
import 'package:come_together2/controller/notification_controller.dart';
import 'package:come_together2/controller/room_list_controller.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../model/come_together_config.dart';

/// app의 일반적인 설정 파일 관리
class GeneralSettingController extends GetxController {
  static GeneralSettingController get to => Get.find();
  final config = ComeTogetherConfig().obs;
  bool _isChanged = false;

  @override
  void onInit() {
    loadLocalSetting();
    super.onInit();
  }

  // ignore: prefer_function_declarations_over_variables
  final _setLocalData = (ComeTogetherConfig config) =>
      Hive.box<ComeTogetherConfig>('comeTogetherConfig').put('config', config);

  /// 첫 로그인시 기록
  void setFirstLogin(bool isFirstRun) {
    bool before = config.value.isFirstRun;
    if (before != isFirstRun) {
      config.value.isFirstRun = isFirstRun;
      _setLocalData(config.value);
    }
  }

  /// 로컬에서 저장된 설정 로드
  void loadLocalSetting() =>
      Hive.box<ComeTogetherConfig>('comeTogetherConfig').isNotEmpty
          ? config.value =
              Hive.box<ComeTogetherConfig>('comeTogetherConfig').values.first
          : null;

  /// 로컬에 설정 저장
  void saveLocalSetting() {
    if (_isChanged) {
      config.value.isShowAlarm
          ? NotificationController()
              .addAllNotification(RoomListController.to.roomMap)
          : NotificationController().cancelAll();
      _setLocalData(config.value);
      _isChanged = false;
      ValidateData().showSnackBar('설정', '수정되었습니다.');
    } else {
      ValidateData().showSnackBar('설정', '변동사항이 없습니다.');
    }
  }

  /// 설정에 동기화 시간 set
  void updateSyncTime(String time) {
    config.value.lastSyncFriendsTime = time;
    config.refresh();
  }

  /// 설정에 알림 표시 여부 set
  void setShowAlarm(bool isShowAlarm) {
    config.value.isShowAlarm = isShowAlarm;
    config.refresh();
    _isChanged = true;
  }
}
