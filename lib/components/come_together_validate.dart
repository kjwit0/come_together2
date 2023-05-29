import 'package:come_together2/model/friend_info.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../controller/friends_controller.dart';

class ValidateData {
  ValidateData._privateConstructor();
  static Fluttertoast toast = Fluttertoast();

  static final ValidateData _instance = ValidateData._privateConstructor();

  factory ValidateData() {
    return _instance;
  }

  bool validateNickname(String nickname) {
    if (nickname.isEmpty) {
      showSnackBar('닉네임 변경', '닉네임을 입력하세요.');
      return false;
    } else if (nickname.length < 2) {
      showSnackBar('닉네임 변경', '닉네임을 2글자 이상 입력하세요.');
      return false;
    }
    return true;
  }

  bool isAddedFriend(String email) {
    // ignore: invalid_use_of_protected_member
    for (FriendInfo friend in FriendsContoller.to.friends.value) {
      if (friend.memberEmail == email) {
        return true;
      }
    }
    return false;
  }

  bool validateTitle(String title) {
    if (title.isEmpty) {
      showSnackBar('모집글 설정', '모집글의 제목을 입력하세요.');
      return false;
    } else if (title.length < 2) {
      showSnackBar('모집글 설정', '모집글의 제목을 2글자 이상 입력하세요.');
      return false;
    }
    return true;
  }

  bool searchEmailForAdd(String email) {
    if (!isEmailFormat(email)) {
      showSnackBar('이메일 입력', '잘못된 이메일 양식 입니다.');
      return false;
    } else if (isAddedFriend(email)) {
      showSnackBar('친구 추가', '이미 친구로 등록 되어있습니다.');
      return false;
    }
    return true;
  }

  bool isEmailFormat(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
  }

  //중복클릭방지
  void showSnackBar(String title, String message) {
    if (!Get.isSnackbarOpen) {
      Get.showSnackbar(GetSnackBar(
        titleText: Text(
          title,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        messageText: Text(
          message,
          style: const TextStyle(color: Colors.black, fontSize: 18),
        ),
        duration: const Duration(seconds: 1),
        snackPosition: SnackPosition.BOTTOM,
        forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
        reverseAnimationCurve: Curves.easeOutSine,
        backgroundColor: Colors.white,
        borderRadius: 10,
      ));
    }
  }
}
