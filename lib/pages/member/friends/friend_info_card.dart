import 'package:come_together2/controller/user_controller.dart';
import 'package:flutter/material.dart';
import '../../../components/come_together_user_icon.dart';
import '../../../components/friend_delete_button.dart';
import '../../../model/friend_info.dart';

// ignore: must_be_immutable
class FriendInfoCard extends StatelessWidget {
  FriendInfoCard({required this.friend, super.key});
  FriendInfo friend;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: UserIconView(url: friend.memberIcon),
            ),
            Text(
              friend.memberNickname,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton(
                  onPressed: UserController.to.isLogin() ? () {} : null,
                  child: const Icon(
                    Icons.call,
                    color: Colors.black54,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: FriendDeleteButton(friendInfo: friend)),
            ]),
          ],
        ),
      ),
    );
  }
}
