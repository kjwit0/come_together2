import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:come_together2/controller/user_controller.dart';
import 'package:come_together2/model/friend_info.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FriendsContoller extends GetxController {
  static FriendsContoller get to => Get.find();

  final searchedFriend = FriendInfo().obs;
  final friends = <FriendInfo>[].obs;

  void loadLocalFriends() {
    FriendsContoller.to.friends.value =
        Hive.box<FriendInfo>('friendsBox').values.toList();
  }

  void addLocalFriend(FriendInfo friend) {
    FriendsContoller.to.friends.value.add(friend);
    Hive.box<FriendInfo>('friendsBox').put(friend.memberId, friend);
  }

  void synchronizeLocalFriend() async {
    FriendInfo tempFriend;
    List<FriendInfo> serverFriends =
        await loadFriendsFromFB(UserController.to.loginUser.value.friends);

    for (var key in Hive.box<FriendInfo>('friendsBox').keys) {
      tempFriend = Hive.box<FriendInfo>('friendsBox').get(key)!;

      //local 데이터가 서버에 없으면 로컬에서 제거
      if (!serverFriends.contains(tempFriend)) {
        Hive.box<FriendInfo>('friendInfoBox').delete(key);
      }
    }

    // 서버의 데이터 local에 추가 및 동기화
    for (FriendInfo friend in serverFriends) {
      addLocalFriend(friend);
    }
  }

  Future<List<FriendInfo>> loadFriendsFromFB(List<String> friends) async {
    List<FriendInfo> tempFriends = [];
    var memberCollection = FirebaseFirestore.instance.collection("member");

    for (var friendId in friends) {
      var userInfo = await memberCollection.doc(friendId).get();
      if (userInfo.exists) {
        tempFriends.add(FriendInfo(
            memberId: userInfo.data()!['memberId'],
            memberNickname: userInfo.data()!['nickname'],
            memberIcon: userInfo.data()!['userIcon'],
            memberEmail: userInfo.data()!['memberEmail']));
      }
    }
    return tempFriends;
  }

  void searchMemberByEmail(String email) async {
    QuerySnapshot searchResult = await FirebaseFirestore.instance
        .collection('member')
        .where("memberEmail", isEqualTo: email)
        .get();

    if (searchResult.docs.isNotEmpty) {
      FriendsContoller.to.searchedFriend.value = FriendInfo(
          memberId: searchResult.docs[0].get('memberId'),
          memberNickname: searchResult.docs[0].get('nickname'),
          memberIcon: searchResult.docs[0].get('userIcon'),
          memberEmail: searchResult.docs[0].get('memberEmail'));
    }
  }

  void clearSearchedFriend() {
    FriendsContoller.to.searchedFriend.value = FriendInfo();
  }
}
