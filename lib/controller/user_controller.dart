// ignore_for_file: prefer_function_declarations_over_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:come_together2/controller/room_list_controller.dart';
import 'package:come_together2/pages/login_main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import '../components/come_together_validate.dart';
import '../model/member.dart';
import '../pages/first_page.dart';
import 'general_setting_controller.dart';
import 'image_pick_controller.dart';

/// 인증 관련 컨트롤러
class UserController extends GetxController {
  static UserController to = Get.find();
  late Rx<User?> user = Rxn<User?>();
  final loginUser = Member().obs;
  static FirebaseAuth authentication = FirebaseAuth.instance;
  String tempNickname = '';

  @override
  void onReady() {
    super.onReady();
    user = Rx<User?>(authentication.currentUser);
    user.bindStream(authentication.userChanges());
    ever(user, _createOrLogin);
  }

  /// 구글 이메일 회원가입 또는 로그인
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      Logger().e(e);
    }
    return null;
  }

  ///로그인에 따른 페이지 전환
  // final _moveToMainPage = (User? user) =>
  //     (user != null) || !GeneralSettingController.to.config.value.isFirstRun
  //         ? Get.offAll(() => LoginMain())
  //         : Get.offAll(() => const FirstPage());

  // /// 로그아웃 및 페이지 전환
  // void logOut() {
  //   RoomListController.to.unbindSteram();
  //   Get.offAll(() => const FirstPage());
  // }

  /// 오프라인 모드 테스트용
  void logOut() {
    RoomListController.to.unbindSteram() ? Get.offAll(() => LoginMain()) : null;
    authentication.signOut();
  }

  bool isLogin() {
    return (user.value == null) ? false : (user.value!.uid != '');
  }

  /// 유저 정보 download 함수
  final _getUserInfoFromFB = (String userId) =>
      FirebaseFirestore.instance.collection("member").doc(userId).get();

  /// 유저 정보 upload 함수
  final _setUserInfoToFB = (User user) =>
      FirebaseFirestore.instance.collection("member").doc(user.uid).set({
        'memberId': user.uid,
        'memberEmail': user.email,
        'nickname': user.displayName,
        'userIcon': 'none',
        'friends': <String>[]
      });

  /// FirebaseAuth에 인증받은 회원정보가 있으면 로그인 없으면 회원정보 생성
  void _createOrLogin(User? user) {
    if (user != null) {
      try {
        _getUserInfoFromFB(user.uid).then((value) => value.exists
            ? loginUser.value = Member.fromJson(value.data()!)
            : _setUserInfoToFB(user).then((value) {
                loginUser.value.memberId = user.uid;
                loginUser.value.memberEmail = user.email!;
                loginUser.value.memberIcon = 'none';
                loginUser.value.friends = <String>[];
              }));
        Get.offAll(() => LoginMain());
      } on FirebaseException catch (e) {
        Logger().e(e);
      }
    } else {
      if (!GeneralSettingController.to.config.value.isFirstRun) {
        Get.offAll(() => LoginMain());
      }
    }
  }

  /// 친구 정보 리스트 download
  Future<List<String>> loadFirebaseFriends() async {
    List<String> data = [];
    if (loginUser.value.memberId != '') {
      var friends = await FirebaseFirestore.instance
          .collection('member')
          .doc(loginUser.value.memberId)
          .get();
      if (friends.exists) {
        data = List<String>.from(friends.data()!['friends']);
      }
    }
    return data;
  }

  /// 유저 정보 update 함수
  final _updateUser = (String memberId, Map<String, dynamic> data) =>
      FirebaseFirestore.instance
          .collection('member')
          .doc(memberId)
          .update(data);

  /// 친구 추가 함수
  void addFriends(String friend) {
    try {
      loginUser.value.friends.add(friend);
      _updateUser(
          loginUser.value.memberId, {'friends': loginUser.value.friends});
    } on FirebaseException catch (e) {
      Logger().e(e);
    }
  }

  /// 친구 삭제 함수
  void deleteFriend(String friend) {
    try {
      loginUser.value.friends.remove(friend);
      _updateUser(
          loginUser.value.memberId, {'friends': loginUser.value.friends});
    } on FirebaseException catch (e) {
      Logger().e(e);
    }
  }

  /// 닉네임 수정 함수
  void updateNickname() {
    try {
      _updateUser(loginUser.value.memberId,
          {'nickname': loginUser.value.memberNickname});
    } on FirebaseException catch (e) {
      Logger().e(e);
    }
  }

  void changeNickname(String newNickname) {
    if (!ValidateData().validateNickname(newNickname)) {
      return;
    } else if (loginUser.value.memberNickname == newNickname) {
      ValidateData().showSnackBar('닉네임 변경', '닉네임이 이전과 동일합니다.');
      return;
    }
    loginUser.value.memberNickname = newNickname;
    updateNickname();
    ValidateData().showSnackBar('닉네임 변경', '변경되었습니다.');
  }

  /// 유저 정보 수정 함수
  void updateUser() {
    try {
      _updateUser(loginUser.value.memberId, loginUser.value.toJson());
    } on FirebaseException catch (e) {
      Logger().e(e);
    }
  }

  void changeUserIcon() {
    ImagePickController.to.uploadImage().then((value) {
      if (value != null) {
        loginUser.value.memberIcon = value;
        loginUser.refresh();
        _updateUser(loginUser.value.memberId, {'userIcon': value});
        ValidateData().showSnackBar('Mypage', '적용되었습니다.');
      }
    });
  }
}
