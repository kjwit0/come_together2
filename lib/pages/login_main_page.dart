import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:come_together2/modul/member.dart';
import 'package:come_together2/pages/chat/room/chat_room_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/user_controller.dart';
import 'member/friends/friend_list.dart';
import 'member/my_page.dart';

class LoginMain extends StatelessWidget {
  LoginMain({super.key});

  final _authentication = FirebaseAuth.instance;
  late Member loginUser;
  int _currentPage = 1;
  late List<Widget> pages;

  @override
  void initState() {
    getCurrentUser();

    pages = [
      FriendList(),
      const ChatRoomList(),
      FriendList(),
    ];
  }

//user login
  void getCurrentUser() async {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        var memberCollection = FirebaseFirestore.instance.collection("member");
        var userInfo = await memberCollection
            .doc(user.uid)
            .get(); //받아오는 방식이므로 await필요(아래거 실행늦게 하게 하려면)
        if (userInfo.exists) {
          //존재성 확인하는 부분.
          Get.put(UserController());
        } else {
          memberCollection.doc(user.uid).set({
            'memberId': user.uid,
            'memberEmail': user.email,
            'nickname': user.displayName,
            'userIcon': 'none',
            'friends': null
          });
        }
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
                    return MyPage(loginUser: loginUser);
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

  //   final _authentication = FirebaseAuth.instance;
//   late Member loginUser;
//   int _currentPage = 1;
//   late List<Widget> pages;

//   @override
//   void initState() {
//     getCurrentUser();

//     pages = [
//       FriendList(),
//       const ChatRoomList(),
//       FriendList(),
//     ];
//   }

// //user login
//   void getCurrentUser() async {
//     try {
//       final user = _authentication.currentUser;
//       if (user != null) {
//         var memberCollection = FirebaseFirestore.instance.collection("member");
//         var userInfo = await memberCollection
//             .doc(user.uid)
//             .get(); //받아오는 방식이므로 await필요(아래거 실행늦게 하게 하려면)
//         if (userInfo.exists) {
//           //존재성 확인하는 부분.
//           Get.put(UserController());
//         } else {
//           memberCollection.doc(user.uid).set({
//             'memberId': user.uid,
//             'memberEmail': user.email,
//             'nickname': user.displayName,
//             'userIcon': 'none',
//             'friends': null
//           });
//         }
//       }
//     } catch (e) {
//       // ignore: avoid_print
//       print(e);
//     }
//   }

//   void setPage(int pageNum) {
//     setState(() {
//       _currentPage = pageNum;
//     });
//   }
}
