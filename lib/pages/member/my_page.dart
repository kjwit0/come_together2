import 'package:come_together2/components/come_together_button.dart';
import 'package:come_together2/components/come_together_validate.dart';
import 'package:come_together2/controller/auth_controller.dart';
import 'package:come_together2/controller/image_pick_controller.dart';
import 'package:flutter/material.dart';
import '../../controller/user_controller.dart';
import 'package:get/get.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? iconURL;
    bool isNewIcon = false;
    bool isNewNickname = false;
    String? newNickname;

    Get.put(ImagePickController());

    return Scaffold(
      appBar: AppBar(
        title: Text('My Page', style: TextStyle(color: Colors.green[300])),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: GetX<UserController>(
          builder: (controller) {
            return ListView(children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(right: 30),
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.network(
                      controller.loginUser.value.memberIcon!,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset('lib/images/play-button.png');
                      },
                    ),
                  ),
                  ComeTogetherButton(
                    text: '유저 아이콘 변경하기',
                    onPressed: () {
                      ImagePickController.to.uploadImage().then((value) {
                        if (value != null) {
                          iconURL = value;
                          isNewIcon = true;
                          ValidateData().showToast('수정하기를 눌러야 반영됩니다.');
                        }
                      });
                    },
                  )
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                      'ID :  ${UserController.to.loginUser.value.memberEmail}',
                      style: const TextStyle(fontSize: 20))),
              Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                      'Nickname :  ${UserController.to.loginUser.value.memberNickname}',
                      style: const TextStyle(fontSize: 20))),
              Row(
                children: [
                  const Text('Nickname : ', style: TextStyle(fontSize: 20)),
                  Expanded(
                    child: TextFormField(
                      maxLength: 15,
                      decoration: const InputDecoration(
                        hintText: '  새로운 닉네임을 입력하세요',
                      ),
                      onChanged: (value) {
                        if (ValidateData().changeNickname(
                            UserController.to.loginUser.value.memberNickname,
                            value)) {
                          newNickname = value;
                          isNewNickname = true;
                        } else {
                          isNewNickname = false;
                        }
                      },
                    ),
                  ),
                ],
              ),
              Container(
                  padding: const EdgeInsets.all(50),
                  child: ComeTogetherButton(
                    text: '로그아웃을 하려면 누르세요',
                    color: Colors.blueGrey,
                    onPressed: () {
                      AuthController.to.logout();
                    },
                  )),
              Container(
                padding: const EdgeInsets.all(30),
                child: ComeTogetherButton(
                  text: '수정하기',
                  onPressed: () {
                    if (isNewIcon || isNewNickname) {
                      if (isNewIcon) {
                        controller.loginUser.value.memberIcon = iconURL;
                      }

                      if (isNewNickname) {
                        controller.loginUser.value.memberNickname =
                            newNickname!;
                      }

                      controller.updateUser();
                      ValidateData().showToast('수정이 완료되었습니다.');
                      Get.back();
                    } else {
                      ValidateData().showToast('변경 사항이 없습니다.');
                    }
                  },
                ),
              ),
            ]);
          },
        ),
      ),
    );
  }
}
