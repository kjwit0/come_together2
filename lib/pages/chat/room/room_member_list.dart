import 'package:flutter/material.dart';
import '../../../components/come_together_user_icon.dart';
import '../../../model/friend_info.dart';

// ignore: must_be_immutable
class RoomMemberList extends StatelessWidget {
  RoomMemberList({required this.memberList, super.key});
  Map<String, FriendInfo> memberList;

  @override
  Widget build(BuildContext context) {
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
