import 'package:come_together2/pages/member/my_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chat_room.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final _authentication = FirebaseAuth.instance;
  User? loginUser;
  List<int> _chatRoomList = [];

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loginUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'COME TOGETHER',
            style: TextStyle(
              color: Colors.green[300],
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.account_circle,
                color: Colors.blue,
                size: 30.0,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const MyPage();
                }));
              },
            )
          ],
        ),
        body: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height - 200,
              left: MediaQuery.of(context).size.width - 100,
              child: FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.add),
              ),
            ),
            Column(children: [
              MaterialButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return _chatRoomList.isEmpty
                        ? const MyPage()
                        : const ChatRoom();
                  }));
                },
                child: _chatRoomList.isEmpty
                    ? const Text('우측 하단의 + 버튼을 눌러서 채팅을 시작하세요!')
                    : const Text('chat list'),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
