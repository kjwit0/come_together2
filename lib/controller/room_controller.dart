import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:come_together2/model/room.dart';
import 'package:get/get.dart';

class RoomController extends GetxController {
  static RoomController get to => Get.find();
  final room = Room().obs;

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

  void addRoom(Room room) {
    FirebaseFirestore.instance
        .collection('chatroom')
        .add(RoomController.to.room.value.toJson());
  }

  Future<String?> generateRoomId() async {
    String? roomId;
    await FirebaseFirestore.instance
        .collection('chatroom')
        .snapshots()
        .length
        .then((value) {
      roomId = 'room_$value';
    });
    return roomId;
  }
}
