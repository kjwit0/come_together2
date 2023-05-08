import 'package:come_together2/modul/friend_info.dart';
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
      appBar: AppBar(),
      body: Column(
        children: [
          MaterialButton(
            onPressed: () {
              friends.add(FriendInfo(
                  memberId: 'memberId',
                  memberNickname: 'memberNickname',
                  memberIcon: 'memberIcon'));
            },
          ),
          const Divider(),
          ValueListenableBuilder(
              valueListenable:
                  Hive.box<FriendInfo>('friendInfoBox').listenable(),
              builder: (context, Box<FriendInfo> friends, widget) {
                return Expanded(
                    child: true
                        ? const Text('empty')
                        : ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, i) {
                              //friends.delete(friends.keys);
                              return ListTile(
                                title: Text('$i'),
                                subtitle: Text('$i sub'),
                              );
                            }));
              })
        ],
      ),
    );
  }
}
