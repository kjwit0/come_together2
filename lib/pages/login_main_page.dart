import 'package:come_together2/modul/member.dart';
import 'package:come_together2/pages/chat/room/chat_room_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'member/friends/member_list.dart';
import 'member/my_page.dart';

class LoginMain extends StatefulWidget {
  const LoginMain({super.key});

  @override
  State<LoginMain> createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain> {
  final _authentication = FirebaseAuth.instance;
  late Member loginUser;
  int _currentPage = 1;

  final pages = [
    const MemberList(),
    const ChatRoomList(),
    const MemberList(),
  ];

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

//user login
  void getCurrentUser() async {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loginUser = Member(
          memberId: user.uid,
          memberEmail: user.email ?? 'none',
          memberNickname: user.displayName ?? 'unknown',
        );
        loginUser.memberIcon = await FirebaseStorage.instance
            .ref()
            .child('userIcon')
            .child('${user.uid}.png')
            .getDownloadURL();
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  void setPage(int pageNum) {
    setState(() {
      _currentPage = pageNum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'COME TOGETHER',
          style: TextStyle(
            color: Colors.green[300],
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.black87,
              backgroundImage: null,
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const MyPage();
                  }));
                },
              ),
            ),
          ),
        ],
      ),
      body: pages[_currentPage],
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        height: 50,
        color: Colors.green[300],
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          MaterialButton(
              child: const Icon(Icons.group),
              onPressed: () {
                setPage(0);
              }),
          MaterialButton(
              child: const Icon(Icons.playlist_add_check),
              onPressed: () {
                setPage(1);
              }),
          MaterialButton(
              child: const Icon(Icons.settings),
              onPressed: () {
                setPage(2);
              })
        ]),
      ),
    );
  }
}
