import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../components/come_together_general.dart';
import '../chat/room/chat_room_list.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _authentication = FirebaseAuth.instance;
  final _sign_up_key = GlobalKey<FormState>();
  String user_id = '';
  String user_nickname = '';
  String user_password = '';
  String user_password_check = '';
  String _errMessege = '';

  bool _tryValidation() {
    final isValid = _sign_up_key.currentState!.validate();
    if (isValid) {
      if (user_password != user_password_check) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('password가 일치하지 않습니다.'),
          backgroundColor: Colors.blue,
        ));
        return false;
      }
      _sign_up_key.currentState!.save();
    }

    return true;
  }

  void _onSignUpPage() {
    Navigator.push(
      context,
      FadePageRoute(page: const SignUpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _sign_up_key,
            child: ListView(children: [
              const Text(
                '회원가입',
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 20),
              UserInfoInputForm(
                  keyIndex: 1,
                  minLength: 4,
                  dataValue: (value) => {user_id = value},
                  columText: 'ID :                  ',
                  textHint: ' ID를 입력해주세요',
                  validatorText: '4 글자 이상 입력해주세요'),
              const SizedBox(
                height: 20,
              ),
              UserInfoInputForm(
                  keyIndex: 1,
                  minLength: 2,
                  dataValue: (value) => {user_nickname = value},
                  columText: 'nickname :    ',
                  textHint: ' 닉네임을 입력해주세요',
                  validatorText: '2 글자 이상 입력해주세요'),
              const SizedBox(
                height: 20,
              ),
              UserInfoInputForm(
                  keyIndex: 2,
                  minLength: 4,
                  obscureText: true,
                  dataValue: (value) => {user_password = value},
                  columText: 'PW :                ',
                  textHint: 'PW를 입력해주세요',
                  validatorText: '4 글자 이상 입력해주세요'),
              const SizedBox(
                height: 20,
              ),
              UserInfoInputForm(
                  keyIndex: 3,
                  minLength: 4,
                  obscureText: true,
                  dataValue: (value) => {user_password_check = value},
                  columText: 'PW (재입력) : ',
                  textHint: 'PW를 입력해주세요',
                  validatorText: '4 글자 이상 입력해주세요'),
              const SizedBox(height: 30),
              Text(_errMessege,
                  style: const TextStyle(color: Colors.red, fontSize: 20)),
              OutlinedButton(
                child: const Text(
                  '회원가입',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () async {
                  if (_tryValidation()) {
                    final newMember =
                        await _authentication.createUserWithEmailAndPassword(
                            email: user_id, password: user_password);
                    if (newMember.user != null) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const ChatList();
                      }));
                    }
                  }
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
