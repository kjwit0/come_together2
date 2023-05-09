import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../modul/member.dart';

class UserController extends GetxController {
  //static UserController instance = Get.find();
  final loginUser = Member().obs;

  // void updateInfo(Member member) {
  //   loginUser.update((val) {
  //     val?.memberEmail = member.memberEmail;
  //     val?.memberId = member.memberId;
  //     val?.memberNickname = member.memberNickname;
  //     val?.memberIcon = member.memberIcon;
  //     val?.friends = member.friends;
  //   });
  // }

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    var userInfo = await FirebaseFirestore.instance
        .collection("member")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    loginUser.value = Member.fromJson(userInfo.data()!);
  }
}
