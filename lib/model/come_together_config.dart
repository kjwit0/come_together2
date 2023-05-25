import 'package:hive_flutter/hive_flutter.dart';
part 'come_together_config.g.dart';

@HiveType(typeId: 3)
class ComeTogetherConfig extends HiveObject {
  ComeTogetherConfig({
    this.isDarkMode = true,
    this.isFirstRun = true,
    this.beforeMiniute = 0,
    this.isShowAlarm = false,
  });

  @HiveField(0)
  bool isDarkMode;

  @HiveField(1)
  bool isFirstRun;

  @HiveField(2)
  int beforeMiniute;

  @HiveField(3)
  bool isShowAlarm;

  @HiveField(4)
  String lastSyncFriendsTime = '';
}
