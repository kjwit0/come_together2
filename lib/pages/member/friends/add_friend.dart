import 'package:come_together2/modul/friend_info.dart';
import 'package:come_together2/pages/member/member_box.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class AddFriend extends StatefulWidget {
  const AddFriend({super.key});

  @override
  State<AddFriend> createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {
  late Box<FriendInfo> friends;

  @override
  void initState() {
    super.initState();
    friends = Hive.box<FriendInfo>('friendInfoBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [Text('friend name'), Text('상태메시지')],
                              ),
                              Text('icon')
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text('대화하기'),
                          ),
                        ]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
