import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../model/member.dart';

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
          'friends': <String>[]
        });

        loginUser.value.memberId = user!.uid;
        loginUser.value.memberEmail = user!.email!;
        loginUser.value.memberIcon = 'none';
        loginUser.value.friends = <String>[];
      }
    }
  }

  void addFriends(String friend) {
    List<String> newFriends = [];
    newFriends.addAll(loginUser.value.friends);
    newFriends.add(friend);
    loginUser.value.friends = newFriends;
  }

  void updateFriends() {
    FirebaseFirestore.instance
        .collection('member')
        .doc(loginUser.value.memberId)
        .update({'friends': loginUser.value.friends});
  }

  void updateNickname() {
    FirebaseFirestore.instance
        .collection('member')
        .doc(loginUser.value.memberId)
        .update({'nickname': loginUser.value.memberNickname});
  }

  void updateUser() {
    FirebaseFirestore.instance
        .collection('member')
        .doc(loginUser.value.memberId)
        .update(Get.find<UserController>().loginUser.value.toJson());
  }
}
