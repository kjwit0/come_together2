import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../modul/friend_info.dart';
import '../modul/member.dart';

class UserController extends GetxController {
  final loginUser = Member().obs;
  var user = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    super.onInit();
    _fetchData();
  }

  void _fetchData() async {
    if (user != null) {
      var memberCollection = FirebaseFirestore.instance.collection("member");
      var userInfo = await memberCollection.doc(user!.uid).get();

      if (userInfo.exists) {
        loginUser.value = Member.fromJson(userInfo.data()!);
      } else {
        memberCollection.doc(user!.uid).set({
          'memberId': user!.uid,
          'memberEmail': user!.email,
          'nickname': user!.displayName,
          'userIcon': 'none',
          'friends': null
        });

        loginUser.value.memberId = user!.uid;
        loginUser.value.memberEmail = user!.email!;
        loginUser.value.memberIcon = 'none';
        loginUser.value.friends = null;
      }
    }
  }

  void addFriend(FriendInfo friend) {
    if (loginUser.value.friends == null) {
      List<FriendInfo> list = [];
      list.add(friend);
      loginUser.value.friends = list;
    } else {
      loginUser.value.friends!.add(friend);
    }
    updateFriends();
  }

  void updateFriends() async {
    if (user != null) {
      FirebaseFirestore.instance
          .collection('member')
          .doc(user!.uid)
          .set(loginUser.value.toJson());
    }
  }
}
