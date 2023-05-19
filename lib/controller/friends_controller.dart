import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:come_together2/components/come_together_validate.dart';
import 'package:come_together2/controller/general_setting_controller.dart';
import 'package:come_together2/controller/user_controller.dart';
import 'package:come_together2/model/friend_info.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class FriendsContoller extends GetxController {
  static FriendsContoller get to => Get.find();

  final searchedFriend = FriendInfo().obs;
  final friends = <FriendInfo>[].obs;

  @override
  void onInit() {
    super.onInit();
    _syncFriends();
  }

  void loadLocalFriends() {
    FriendsContoller.to.friends.value =
        Hive.box<FriendInfo>('friendsBox').values.toList();
  }

  void addLocalFriend(FriendInfo friend) {
    // ignore: invalid_use_of_protected_member
    FriendsContoller.to.friends.value.add(friend);
    Hive.box<FriendInfo>('friendsBox').put(friend.memberId, friend);
    FriendsContoller.to.friends.refresh();
  }

  void _syncFriends() {
    GeneralSettingController.to.updateSyncTime(
        DateFormat('yyyy-MM-dd  hh:mm.ss')
            .format(Timestamp.now().toDate())
            .toString());

    print(Timestamp.now());
    ValidateData().showToast('동기화 되었습니다.');
    // for cancel variable
    Timer timer = Timer.periodic(const Duration(seconds: 30), (syncTimer) {
      synchronizeLocalFriend();

      GeneralSettingController.to.updateSyncTime(
          DateFormat('yyyy-MM-dd  hh:mm.ss')
              .format(Timestamp.now().toDate())
              .toString());

      print(Timestamp.now());
      ValidateData().showToast('동기화 되었습니다.');
    });
  }

  void synchronizeLocalFriend() async {
    List<String> serverFriends = await UserController.to.loadFirebaseFriends();

    //local 데이터가 서버에 없으면 로컬에서 제거
    for (var key in Hive.box<FriendInfo>('friendsBox').keys) {
      if (!serverFriends.contains(key)) {
        Hive.box<FriendInfo>('friendsBox').delete(key);
        List<FriendInfo> friends = FriendsContoller.to.friends;
        for (var i = 0; i < friends.length; i++) {
          friends[i].memberId == key;
          friends.removeAt(i);
        }
      }
    }

    // 서버의 데이터 local에 추가 및 동기화
    for (String id in serverFriends) {
      if (!Hive.box<FriendInfo>('friendsBox').containsKey(id)) {
        loadFriendFromFB(id).then((value) {
          if (value != null) {
            addLocalFriend(value);
          }
        });
      }
    }
  }

  Future<FriendInfo?> loadFriendFromFB(String memberId) async {
    var memberCollection = FirebaseFirestore.instance.collection("member");

    var tempFriend = await memberCollection.doc(memberId).get();
    if (tempFriend.exists) {
      return FriendInfo(
          memberId: tempFriend.data()!['memberId'],
          memberNickname: tempFriend.data()!['nickname'],
          memberIcon: tempFriend.data()!['userIcon'],
          memberEmail: tempFriend.data()!['memberEmail']);
    }
    return null;
  }

  Future<Map<String, FriendInfo>> loadFriendsFromFB(
      List<String> friends) async {
    Map<String, FriendInfo> tempFriends = {};

    var memberCollection = FirebaseFirestore.instance.collection("member");

    for (var friendId in friends) {
      var userInfo = await memberCollection.doc(friendId).get();
      if (userInfo.exists) {
        tempFriends = {
          userInfo.data()!['memberId']: FriendInfo(
              memberId: userInfo.data()!['memberId'],
              memberNickname: userInfo.data()!['nickname'],
              memberIcon: userInfo.data()!['userIcon'],
              memberEmail: userInfo.data()!['memberEmail'])
        };
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

  void deleteFriend(FriendInfo friend) {
    Hive.box<FriendInfo>('friendsBox').delete(friend.memberId);
    UserController.to.deleteFriend(friend.memberId);
    friends.value.remove(friend);
    ValidateData().showToast('삭제 되었습니다.');
    friends.refresh();
  }
}
