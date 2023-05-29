import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:come_together2/components/come_together_validate.dart';
import 'package:come_together2/controller/general_setting_controller.dart';
import 'package:come_together2/model/friend_info.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import 'user_controller.dart';

/// 친구 관련 모듈 관리
class FriendsContoller extends GetxController {
  static FriendsContoller get to => Get.find();
  final searchedFriend = FriendInfo().obs;
  final friends = <FriendInfo>[].obs;
  final friendsBox = Hive.box<FriendInfo>('friendsBox');

  /// 로컬의 저장된 친구 정보 로드
  void loadLocalFriends() =>
      FriendsContoller.to.friends.value = friendsBox.values.toList();

  /// 로컬에 친구 정보 저장
  void addLocalFriend(FriendInfo friend) {
    FriendsContoller.to.friends.add(friend);
    friendsBox.put(friend.memberId, friend);
    FriendsContoller.to.friends.refresh();
  }

  /// 서버의 친구 정보와 로컬의 정보를 동기화
  void syncFriends() {
    if (UserController.to.isLogin()) {
      GeneralSettingController.to.updateSyncTime(
          DateFormat('yyyy-MM-dd  hh:mm.ss')
              .format(Timestamp.now().toDate())
              .toString());

      _synchronizeLocalFriend();
    }
    // 자동동기화 기능
    // Timer timer = Timer.periodic(const Duration(seconds: 30), (syncTimer) {
    //   synchronizeLocalFriend();

    //   GeneralSettingController.to.updateSyncTime(
    //       DateFormat('yyyy-MM-dd  hh:mm.ss')
    //           .format(Timestamp.now().toDate())
    //           .toString());
    //   ValidateData().showToast('동기화 되었습니다.');
    // });
  }

  void _synchronizeLocalFriend() async {
    List<String> serverFriends = await UserController.to.loadFirebaseFriends();

    //local 데이터가 서버에 없으면 로컬에서 제거
    for (var key in friendsBox.keys) {
      if (!serverFriends.contains(key)) {
        friendsBox.delete(key);
        List<FriendInfo> friends = FriendsContoller.to.friends;

        for (var i = 0; i < friends.length; i++) {
          friends[i].memberId == key;
          friends.removeAt(i);
        }
      }
    }

    // 서버의 데이터 local에 추가 및 동기화
    for (String id in serverFriends) {
      friendsBox.containsKey(id)
          ? putFriendToLocal(id, updateLocalFriend)
          : putFriendToLocal(id, addLocalFriend);
    }
    friends.refresh();
  }

  void putFriendToLocal(String id, Function function) =>
      loadFriendFromFB(id).then((value) {
        (value == null) ? null : function(value);
      });

  void updateLocalFriend(FriendInfo friend) {
    friendsBox.put(friend.memberId, friend);
    for (var i = 0; i < friends.length; i++) {
      (friends[i].memberId == friend.memberId) ? (friends[i] = friend) : null;
    }
  }

  ///서버에 해당하는 Id의 친구 정보를 로드
  Future<FriendInfo?> loadFriendFromFB(String memberId) async {
    try {
      var memberCollection = FirebaseFirestore.instance.collection("member");

      var tempFriend = await memberCollection.doc(memberId).get();
      if (tempFriend.exists) {
        return FriendInfo(
            memberId: tempFriend.data()!['memberId'],
            memberNickname: tempFriend.data()!['nickname'],
            memberIcon: tempFriend.data()!['userIcon'],
            memberEmail: tempFriend.data()!['memberEmail']);
      }
    } on FirebaseException catch (e) {
      Logger().e(e);
    }
    return null;
  }

  ///서버에 해당하는 모든 Id 정보를 로드
  Future<Map<String, FriendInfo>> loadFriendsFromFB(
      List<String> friends) async {
    Map<String, FriendInfo> tempFriends = {};
    try {
      var memberCollection = FirebaseFirestore.instance.collection("member");

      for (var friendId in friends) {
        var userInfo = await memberCollection.doc(friendId).get();

        if (userInfo.exists) {
          tempFriends[friendId] = FriendInfo(
              memberId: userInfo.data()!['memberId'],
              memberNickname: userInfo.data()!['nickname'],
              memberIcon: userInfo.data()!['userIcon'],
              memberEmail: userInfo.data()!['memberEmail']);
        }
      }
    } on FirebaseException catch (e) {
      Logger().e(e);
    }

    return tempFriends;
  }

  ///서버에서 email  에 해당하는 멤버 정보를 로드
  void searchMemberByEmail(String email) async {
    try {
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
    } on FirebaseException catch (e) {
      Logger().e(e);
    }
  }

  /// 컨트롤러 내 친구 정보를 제거
  void clearSearchedFriend() {
    FriendsContoller.to.searchedFriend.value = FriendInfo();
  }

  /// 해당하는 친구의 정보를 서버에서 제거
  void deleteFriend(FriendInfo friend) {
    friendsBox.delete(friend.memberId);
    UserController.to.deleteFriend(friend.memberId);
    friends.remove(friend);
    ValidateData().showSnackBar('친구삭제', '삭제 되었습니다.');
    friends.refresh();
  }
}
