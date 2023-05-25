import 'package:come_together2/controller/room_list_controller.dart';
import 'package:flutter/material.dart';
import '../../../components/come_together_user_icon.dart';
import '../../../model/friend_info.dart';

class RoomMemberList extends StatelessWidget {
  const RoomMemberList({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, FriendInfo> memberList = RoomListController.to.friendsMap;
    return (memberList.isEmpty)
        ? const Text('data loading')
        : SizedBox(
            height: (MediaQuery.of(context).size.height) * 3 / 5,
            child: ListView.builder(
                itemCount: memberList.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(1),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            UserIconView(
                              url: memberList[memberList.keys.elementAt(index)]!
                                  .memberIcon,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 30),
                              child: Text(
                                memberList[memberList.keys.elementAt(index)]!
                                    .memberNickname,
                              ),
                            ),
                          ]),
                    ),
                  );
                }),
          );
  }
}
