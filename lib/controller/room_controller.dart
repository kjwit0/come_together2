import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:come_together2/components/come_together_validate.dart';
import 'package:come_together2/controller/date_time_controller.dart';
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
  final roomMembers = <String, FriendInfo>{}.obs;

  void createRoom() {
    if (validateCreateRoom()) {
      room.value.createTime = Timestamp.now();
      room.value.meetDate = DateTimeController.to.date.value;
      room.value.meetTime = DateTimeController.to.time.value;

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

  void loadRoom(String roomId) {
    bindStream(roomId);
    loadRoomMembersInfo();
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
    } else if (DateTimeController.to.date.value.isEmpty) {
      ValidateData().showToast('날짜를 입력해주세요');
      return false;
    } else if (DateTimeController.to.time.value.isEmpty) {
      ValidateData().showToast('시간을 입력해주세요');
      return false;
    }
    return true;
  }

  void clearRoomInfo() {
    room.value = Room();
  }

  void loadRoomMembersInfo() {
    FriendsContoller.to.loadFriendsFromFB(room.value.joinMember).then((value) {
      RoomController.to.roomMembers.value = value;
    });
  }

  void getRoomMemberById(String memberId) {}

  void addRoomMember(String memberId) {
    room.value.joinMember.add(memberId);
    FirebaseFirestore.instance
        .collection('chatroom')
        .doc(room.value.roomId)
        .update({'joinMember': jsonEncode(room.value.joinMember)});
  }

  void bindStream(String roomId) {
    room.bindStream(FirebaseFirestore.instance
        .collection('chatroom')
        .doc(roomId)
        .snapshots()
        .map((DocumentSnapshot<Map<String, dynamic>> query) {
      return Room.fromJson(query.data()!);
    }));
  }

  FriendInfo getFriendInRoom(String memberId) {
    if (roomMembers.containsKey(memberId)) {
      return roomMembers[memberId]!;
    }
    return FriendInfo(
        memberId: '',
        memberEmail: '',
        memberNickname: '나간 멤버',
        memberIcon: 'none');
  }

  void updateRoom(String title) {
    bool isChanged = false;
    if (title != '') {
      room.value.roomTitle = title;
      isChanged = true;
    }
    String date = DateTimeController.to.date.value;
    if (date != '') {
      room.value.meetDate = date;
      isChanged = true;
    }
    String time = DateTimeController.to.time.value;
    if (time != '') {
      room.value.meetTime = time;
      isChanged = true;
    }
    if (isChanged) {
      FirebaseFirestore.instance
          .collection('chatroom')
          .doc(room.value.roomId)
          .update(room.value.toJson());
    }
  }
}
