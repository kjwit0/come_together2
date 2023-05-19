import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 1)
class ComeTogetherConfig extends HiveObject {
  ComeTogetherConfig(
      {this.isDarkMode = true, this.isFirstRun = true, this.beforeMiniute = 0});

  @HiveField(0)
  bool isDarkMode;

  @HiveField(1)
  bool isFirstRun;

  @HiveField(2)
  int beforeMiniute;

  String lastSyncFriendsTime = '';
}
