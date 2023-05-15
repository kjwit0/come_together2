import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:come_together2/components/come_together_validate.dart';
import 'package:come_together2/controller/user_controller.dart';
import 'package:come_together2/model/friend_info.dart';
import 'package:come_together2/model/room.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'friends_controller.dart';

class RoomController extends GetxController {
  static RoomController get to => Get.find();
  final room = Room().obs;
  final roomMembers = <FriendInfo>[].obs;

  void initRoom(Map<String, dynamic> json) {
    room.value = Room.fromJson(json);
  }

  Future<bool> getRoom() async {
    bool result = false;
    var chatRoomCollection = FirebaseFirestore.instance.collection("chatRoom");
    var loadedRoom = await chatRoomCollection
        .where('joinMember', isEqualTo: RoomController.to.room.value.roomId)
        .get();

    if (loadedRoom.docs.isNotEmpty) {
      RoomController.to.room.value = Room.fromJson(loadedRoom.docs[0].data());
      result = true;
    }
    return result;
  }

  void createRoom() {
    if (validateCreateRoom()) {
      room.value.createTime = Timestamp.now();
      RoomController.to.room.value.joinMember
          .add(UserController.to.loginUser.value.memberId);
      FirebaseFirestore.instance
          .collection('chatroom')
          .add(room.toJson())
          .then((DocumentReference doc) {
        FirebaseFirestore.instance
            .collection('chatroom')
            .doc(doc.id)
            .update({'roomId': doc.id});
      });
    }
  }

  void showDatePickerPop(BuildContext context) async {
    Future<DateTime?> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(), //초기값
      firstDate: DateTime(2020), //시작일
      lastDate: DateTime.now().add(const Duration(days: 60)), //마지막일
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(), //다크 테마
          child: child!,
        );
      },
    );
    DateTime? dateTime = await selectedDate;

    if (dateTime != null) {
      room.value.meetDate = DateFormat('y-M-d').format(dateTime);
      room.refresh();
    }
  }

  void showTimePickerPop(BuildContext context) async {
    Future<TimeOfDay?> selectedTime = showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    TimeOfDay? time = await selectedTime;

    if (time != null) {
      var hour = time.hour.toString().padLeft(2, "0");
      var min = time.minute.toString().padLeft(2, "0");
      room.value.meetTime = '$hour:$min';
      room.refresh();
    }
  }

  bool validateCreateRoom() {
    if (room.value.roomTitle.length < 2) {
      ValidateData().showToast('모집글의 제목을 2 글자 이상 입력해주세요');
      return false;
    } else if (room.value.meetDate.isEmpty) {
      ValidateData().showToast('날짜를 입력해주세요');
      return false;
    } else if (room.value.meetTime.isEmpty) {
      ValidateData().showToast('시간을 입력해주세요');
      return false;
    }
    return true;
  }

  void clearRoomInfo() {
    room.value = Room();
  }

  void getRoomMembersInfo() {
    FriendsContoller.to.loadFriendsFromFB(room.value.joinMember).then((value) {
      RoomController.to.roomMembers.value = value;
    });
  }
}
