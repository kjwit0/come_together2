import 'package:come_together2/model/friend_info.dart';
import 'package:come_together2/model/room.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../controller/friends_controller.dart';

class ValidateData {
  ValidateData._privateConstructor();

  static final ValidateData _instance = ValidateData._privateConstructor();

  factory ValidateData() {
    return _instance;
  }

  bool validateNickname(String nickname) {
    if (nickname.isEmpty) {
      showToast('닉네임을 입력하세요.');
      return false;
    } else if (nickname.length < 2) {
      showToast('닉네임을 2글자 이상 입력하세요.');
      return false;
    }
    return true;
  }

  bool changeNickname(String nickname, String newNickname) {
    if (!validateNickname(newNickname)) {
      return false;
    } else if (nickname == newNickname) {
      showToast('닉네임이 이전과 동일합니다.');
      return false;
    }
    return true;
  }

  bool isAddedFriend(String email) {
    for (FriendInfo friend in FriendsContoller.to.friends.value) {
      if (friend.memberEmail == email) {
        return true;
      }
    }
    return false;
  }

  bool validateTitle(String title) {
    if (title.isEmpty) {
      showToast('모집글의 제목을 입력하세요.');
      return false;
    } else if (title.length < 2) {
      showToast('모집글의 제목을 2글자 이상 입력하세요.');
      return false;
    }
    return true;
  }

  bool searchEmailForAdd(String email) {
    if (!isEmailFormat(email)) {
      showToast('잘못된 이메일 양식 입니다.');
      return false;
    } else if (isAddedFriend(email)) {
      showToast('이미 친구로 등록 되어있습니다.');
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
}
