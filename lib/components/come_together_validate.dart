import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ValidataData {
  ValidataData._privateConstructor();

  static final ValidataData _instance = ValidataData._privateConstructor();

  factory ValidataData() {
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

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
  }
}
