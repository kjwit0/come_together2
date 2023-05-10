import 'package:come_together2/modul/friend_info.dart';
import 'package:get/get.dart';

class FriendsContoller extends GetxController {
  static FriendsContoller get to => Get.find();

  final friends = <FriendInfo>[].obs;

  void changeFriends(List<FriendInfo> friends) {
    FriendsContoller.to.friends.value = friends;
  }
}
