import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../components/come_together_colors.dart';
import '../../modul/member.dart';

// ignore: must_be_immutable
class MyPage extends StatefulWidget {
  const MyPage({super.key});
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String _newNickname = '';
  bool _isChanged = false;
  File? pickedImage;
  late Member _loginUser;
  late DocumentReference<Map<String, dynamic>> userCollection;
  final TextEditingController _nicknameComtroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    //_loginUser = widget.loginUser;
    userCollection = FirebaseFirestore.instance
        .collection("member")
        .doc(_loginUser.memberId);
  }

  void _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImageFile = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50, maxHeight: 150);
    setState(() {
      if (pickedImageFile != null) {
        pickedImage = File(pickedImageFile.path);
      }
    });
  }

  // void _doChangeImage() async {
  //   if (pickedImage != null) {
  //     var userIcons = FirebaseStorage.instance
  //         .ref()
  //         .child('userIcon')
  //         .child('${widget.loginUser.memberId}.png');
  //     _isChanged = true;

  //     await userIcons.putFile(pickedImage!);
  //     _loginUser.memberIcon = await userIcons.getDownloadURL();
  //   }
  // }

  void _doChangeNickname() async {
    if (_newNickname != '') {
      if (_newNickname.length < 2) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('닉네임을 2글자 이상 입력하세요'),
          duration: Duration(seconds: 1),
        ));
      } else {
        if (_loginUser.memberNickname == _newNickname) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('동일한 닉네임 입니다.'),
            duration: Duration(seconds: 1),
          ));
        } else {
          _nicknameComtroller.clear();
          _isChanged = true;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Page', style: TextStyle(color: Colors.green[300])),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            child: Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: 100,
                          height: 100,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.black87,
                            backgroundImage: null,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _pickImage,
                          child: const Text('유저 아이콘 변경하기',
                              style: TextStyle(color: Colors.white70)),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text('ID :  ${_loginUser.memberEmail}',
                        style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 20),
                    Text('Nickname :  ${_loginUser.memberNickname}',
                        style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text('Nickname : ',
                            style: TextStyle(fontSize: 20)),
                        Expanded(
                          child: TextFormField(
                            maxLength: 15,
                            controller: _nicknameComtroller,
                            decoration: const InputDecoration(
                              hintText: '  새로운 닉네임을 입력하세요',
                            ),
                            onChanged: (value) {
                              _newNickname = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all(
                            Colors.white54,
                          ),
                          backgroundColor: MaterialStateProperty.resolveWith(
                            (states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Colors.green[300];
                              } else {
                                return CometogetherColors.primaryColor;
                              }
                            },
                          ),
                        ),
                        child: const Text(
                          '로그아웃을 하려면 누르세요',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: OutlinedButton(
                        child: const Text(
                          '수정하기',
                          style: TextStyle(color: Colors.white38),
                        ),
                        onPressed: () {
                          //_doChangeImage();
                          _doChangeNickname();

                          if (_isChanged) {
                            userCollection.set(_loginUser.toJson());
                          }

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: _isChanged
                                ? const Text('수정 되었습니다.')
                                : const Text('변경된 내용이 없습니다.'),
                            duration: const Duration(seconds: 1),
                          ));
                          setState(() {});
                        },
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
