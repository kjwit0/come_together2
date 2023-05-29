// ignore_for_file: prefer_function_declarations_over_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:come_together2/components/come_together_validate.dart';
import 'package:come_together2/controller/date_time_controller.dart';
import 'package:come_together2/controller/room_list_controller.dart';
import 'package:come_together2/model/friend_info.dart';
import 'package:come_together2/model/room.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'notification_controller.dart';
import 'user_controller.dart';

/// 방을 생성하거나 변경할 때, 임시로 사용하는 컨트롤러
class RoomController extends GetxController {
  static RoomController get to => Get.find();
  final room = Room().obs;
  final roomMembers = <String, FriendInfo>{}.obs;

  /// roomController 내부의 생성된 방 정보에서 <br>
  /// 모임 예약시간이 현재 보다 10분 이후 인지 확인
  bool _isBeforeTime() {
    String meetDateTime =
        '${DateTimeController.to.date.value} ${DateTimeController.to.time.value}:00';

    DateTime dateTime = DateFormat("yyyy-MM-dd hh:mm:ss")
        .parse(meetDateTime)
        .subtract(const Duration(minutes: 10));

    return (dateTime.compareTo(DateTime.now()) < 0);
  }

  /// 컨트롤러에 있는 방 정보가 생성 가능한 상태인지 판별
  bool _validateCreateRoom() {
    if (room.value.roomTitle.length < 2) {
      ValidateData().showSnackBar('모집글 제목 설정', '모집글의 제목을 2 글자 이상 입력해주세요');
      return false;
    } else if (DateTimeController.to.date.value.isEmpty) {
      ValidateData().showSnackBar('날짜 설정', '날짜를 입력해주세요');
      return false;
    } else if (DateTimeController.to.time.value.isEmpty) {
      ValidateData().showSnackBar('시간 설정', '시간을 입력해주세요');
      return false;
    } else if (_isBeforeTime()) {
      ValidateData().showSnackBar('시간 설정', '약속시간은 10분 후 부터 가능합니다.');
      return false;
    }

    return true;
  }

  /// 컨트롤러의 방 정보가 생성 가능한 상태이면 서버에 업로드
  bool createRoom() {
    try {
      if (_validateCreateRoom()) {
        room.value.createTime = Timestamp.now();
        room.value.meetDate = DateTimeController.to.date.value;
        room.value.meetTime = DateTimeController.to.time.value;
        room.value.notificationId = RoomListController.to.roomMap.length;
        room.value.joinMember.add(UserController.to.loginUser.value.memberId);

        //방 서버에 업로드 후 생성된 키를 받아와서 필드 값으로 입력
        FirebaseFirestore.instance
            .collection('chatroom')
            .add(room.toJson())
            .then((DocumentReference doc) {
          FirebaseFirestore.instance
              .collection('chatroom')
              .doc(doc.id)
              .update({'roomId': doc.id});
        });

        return true;
      }
    } on FirebaseException catch (e) {
      Logger().e(e);
    }

    return false;
  }

  /// 컨트롤러 내부의 룸 정보를 초기화
  void clearRoomInfo() {
    room.value = Room();
  }

  /// 선택한 방 내부의 member 정보를 get
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

  /// 모임글 내부 정보를 수정
  void updateRoom(String title) {
    bool isChanged = false;
    bool isTimeChanged = false;

    if (title != '') {
      room.value.roomTitle = title;
      isChanged = true;
    }
    String date = DateTimeController.to.date.value;
    if (date != '') {
      room.value.meetDate = date;
      isTimeChanged = true;
    }
    String time = DateTimeController.to.time.value;
    if (time != '') {
      room.value.meetTime = time;
      isTimeChanged = true;
    }
    if (isTimeChanged) {
      if (_isBeforeTime()) {
        ValidateData().showSnackBar('시간 설정', '약속시간은 10분 후 부터 가능합니다.');
        return;
      }

      NotificationController().updateNotification(room.value);
    }

    if (isChanged || isTimeChanged) {
      ValidateData().showToast('수정 되었습니다.');
      try {
        FirebaseFirestore.instance
            .collection('chatroom')
            .doc(room.value.roomId)
            .update(room.value.toJson());
      } on FirebaseException catch (e) {
        Logger().e(e);
      }
    }
  }
}
