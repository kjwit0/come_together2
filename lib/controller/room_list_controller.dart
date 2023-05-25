import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:come_together2/controller/notification_controller.dart';
import 'package:come_together2/controller/user_controller.dart';
import 'package:come_together2/model/friend_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../model/room.dart';
import 'friends_controller.dart';

/// 방 정보를 서버와 로컬을 동기화 하는 클래스
class RoomListController extends GetxController {
  static RoomListController get to => Get.find();
  final roomMap = <String, Room>{}.obs;
  final friendsMap = <String, FriendInfo>{}.obs;

  /// local 에 저장된 방정보를 로드 한다.
  void loadLocalRooms() {
    for (var value in Hive.box<Room>('roomBox').values) {
      roomMap[value.roomId] = value;
    }
  }

  /// 인터넷 접속이 되면 서버의 정보를 로컬에 동기화 <br>
  /// 접속 실패시 미실행 및 에러 정보 출력
  void bindRoomMapStream() {
    try {
      roomMap.bindStream(FirebaseFirestore.instance
          .collection('chatroom')
          .where('joinMember',
              arrayContains: FirebaseAuth.instance.currentUser!.uid)
          .snapshots()
          .map((QuerySnapshot<Map<String, dynamic>> query) {
        Map<String, Room> temp = {};
        for (var doc in query.docs) {
          //변경이 될때마다 실행됨
          Room json = Room.fromJson(doc.data());
          syncLocalRoomMap(json);
          temp[doc.data()['roomId']] = json;
        }
        return temp;
      }));
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  /// 모임글의 세부 정보가 같은지 다른지 확인
  bool isSameRoomInfo(Room ref, Room compare) {
    return (ref.roomTitle == compare.roomTitle) &&
        (ref.meetDate == compare.meetDate) &&
        (ref.meetTime == compare.meetTime);
  }

  /// 기본의 모임글 정보의 변경이 있는 경우 <br>
  /// 해당하는 모임글의 정보를 반영하여 로컬 데이터 및 알람을 수정
  void syncLocalRoomMap(Room tempRoom) {
    //기존에 존재하는 방인 경우
    if (roomMap[tempRoom.roomId] != null) {
      if (!isSameRoomInfo(roomMap[tempRoom.roomId]!, tempRoom)) {
        tempRoom.notificationId = roomMap[tempRoom.roomId]!.notificationId;
        NotificationController().updateNotification(tempRoom);
        Hive.box<Room>('roomBox').put(tempRoom.roomId, tempRoom);
      }
    } else {
      print('방생성');
      // 기존에 존재하지 않는 방인 경우
      tempRoom.notificationId = roomMap.length;
      roomMap[tempRoom.roomId] = tempRoom;
      NotificationController().addNotification(tempRoom);
      Hive.box<Room>('roomBox').put(tempRoom.roomId, tempRoom);
    }
  }

  /// 특정 모임방에서 나가기를 누른 경우 <br>
  /// 서버 및 로컬 데이터 제거 및 알람 취소
  void exitRoom(String roomId) {
    if (roomMap.containsKey(roomId)) {
      try {
        roomMap[roomId]!
            .joinMember
            .remove(UserController.to.loginUser.value.memberId);
        Hive.box<Room>('roomBox').delete(roomId);

        NotificationController().cancelAt(roomMap[roomId]!.notificationId);

        FirebaseFirestore.instance
            .collection('chatroom')
            .doc(roomId)
            .update({'joinMember': roomMap[roomId]!.joinMember}).then(
                (value) => roomMap.remove(roomId));
      } on FirebaseException catch (e) {
        print(e);
      }
    }
  }

  /// 방에 참여한 멤버의 정보(닉네임,아이콘)를 서버에서 로드
  void loadRoomMembersInfo(String roomId) {
    try {
      if (roomMap.containsKey(roomId)) {
        FriendsContoller.to
            .loadFriendsFromFB(roomMap[roomId]!.joinMember)
            .then((value) {
          friendsMap.value = value;
        });
      }
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  /// 방에 새로운 인원 초대
  void addRoomMember(String roomId, String memberId) {
    if (roomMap.containsKey(roomId)) {
      try {
        roomMap[roomId]!.joinMember.add(memberId);
        FirebaseFirestore.instance
            .collection('chatroom')
            .doc(roomId)
            .update({'joinMember': jsonEncode(roomMap[roomId]!.joinMember)});
      } on FirebaseException catch (e) {
        print(e);
      }
    }
  }
}
