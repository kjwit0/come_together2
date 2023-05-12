import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:come_together2/model/friend_info.dart';
import 'package:get/get.dart';

class FriendsContoller extends GetxController {
  static FriendsContoller get to => Get.find();

  final friends = <FriendInfo>[].obs;
  final searchedFriend = FriendInfo().obs;

  void loadFriends(List<String> friends) async {
    List<FriendInfo> tempFriends = [];
    var memberCollection = FirebaseFirestore.instance.collection("member");

    for (var friendId in friends) {
      var userInfo = await memberCollection.doc(friendId).get();
      if (userInfo.exists) {
        tempFriends.add(FriendInfo(
            memberId: userInfo.data()!['memberId'],
            memberNickname: userInfo.data()!['nickname'],
            memberIcon: userInfo.data()!['userIcon']));
      }
    }
    FriendsContoller.to.friends.value = tempFriends;
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
          memberIcon: searchResult.docs[0].get('userIcon'));
    }
  }

  void clearSearchedFriend() {
    FriendsContoller.to.searchedFriend.value = FriendInfo();
  }
}
