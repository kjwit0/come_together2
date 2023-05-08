import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'chat_room.dart';
import 'chat_room_add.dart';

class ChatRoomList extends StatefulWidget {
  const ChatRoomList({super.key});

  @override
  State<ChatRoomList> createState() => _ChatRoomListState();
}

class _ChatRoomListState extends State<ChatRoomList> {
  final _authentication = FirebaseAuth.instance;
  User? loginUser;
  String? loginUserIcon;
  List<int> _chatRoomList = [];

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loginUser = user;
      }
    } catch (e) {
      print(e);
    }
    final userIcon = await FirebaseStorage.instance
        .ref()
        .child('userIcon')
        .child(loginUser!.uid + '.png')
        .getDownloadURL();
    loginUserIcon = userIcon;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                        ? const ChatRoomAdd()
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
