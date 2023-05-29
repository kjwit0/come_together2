import 'package:come_together2/controller/friends_controller.dart';
import 'package:come_together2/model/friend_info.dart';
import 'package:flutter/material.dart';

import '../controller/user_controller.dart';

// ignore: must_be_immutable
class FriendDeleteButton extends StatelessWidget {
  FriendDeleteButton({required this.friendInfo, super.key});
  FriendInfo friendInfo;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        onPressed: UserController.to.isLogin()
            ? () {
                showDialog(
                    context: context,
                    barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                    builder: (BuildContext context) {
                      return AlertDialog(
                          content: Text(
                            '${friendInfo.memberNickname} 님을 친구에서 제거합니다.',
                          ),
                          insetPadding: const EdgeInsets.fromLTRB(0, 80, 0, 80),
                          actions: [
                            TextButton(
                                child: const Text(
                                  '제거',
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  FriendsContoller.to.deleteFriend(friendInfo);
                                  Navigator.of(context).pop();
                                }),
                            TextButton(
                                child: const Text(
                                  '취소',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }),
                          ]);
                    });
              }
            : null,
        child: const Icon(
          Icons.person_remove_outlined,
          color: Colors.black54,
        ));
  }
}
