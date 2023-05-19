import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:come_together2/components/come_together_validate.dart';
import 'package:come_together2/controller/date_time_controller.dart';
import 'package:come_together2/controller/user_controller.dart';
import 'package:come_together2/model/friend_info.dart';
import 'package:come_together2/model/room.dart';
import 'package:get/get.dart';
import 'friends_controller.dart';

class RoomController extends GetxController {
  static RoomController get to => Get.find();
  final room = Room().obs;
  final roomMembers = <String, FriendInfo>{}.obs;

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

  void clearRoomInfo() {
    room.value = Room();
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

  void loadRoomMembersInfo() {
    FriendsContoller.to.loadFriendsFromFB(room.value.joinMember).then((value) {
      RoomController.to.roomMembers.value = value;
    });
  }

  void addRoomMember(String memberId) {
    room.value.joinMember.add(memberId);
    FirebaseFirestore.instance
        .collection('chatroom')
        .doc(room.value.roomId)
        .update({'joinMember': jsonEncode(room.value.joinMember)});
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
      ValidateData().showToast('수정 되었습니다.');
      room.refresh();
      FirebaseFirestore.instance
          .collection('chatroom')
          .doc(room.value.roomId)
          .update(room.value.toJson());
    }
  }

  void exitRoom() {
    if (room.value.joinMember
        .remove(UserController.to.loginUser.value.memberId)) {
      FirebaseFirestore.instance
          .collection('chatroom')
          .doc(room.value.roomId)
          .update(room.value.toJson());
    }
  }
}
