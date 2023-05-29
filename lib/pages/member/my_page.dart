import 'package:come_together2/components/come_together_button.dart';
import 'package:come_together2/controller/user_controller.dart';
import 'package:come_together2/controller/image_pick_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nicknameController = TextEditingController();
    Get.put(ImagePickController());

    return GestureDetector(
      onTap: () {
        //FocusManager.instance.primaryFocus?.unfocus();
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                      child: (controller.loginUser.value.memberIcon != 'none')
                          ? FadeInImage.assetNetwork(
                              image: controller.loginUser.value.memberIcon!,
                              placeholder: 'lib/images/loading.gif',
                              fit: BoxFit.fill,
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                    'lib/images/play-button.png');
                              },
                            )
                          : Image.asset(
                              'lib/images/play-button.png',
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stackTrace) {
                                return const Text('');
                              },
                            ),
                    ),
                    ComeTogetherButton(
                      text: '유저 아이콘 변경하기',
                      onPressed: () {
                        controller.changeUserIcon();
                      },
                    )
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Text(
                        'ID :  ${controller.loginUser.value.memberEmail}',
                        style: const TextStyle(fontSize: 20))),
                Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Text(
                        'Nickname :  ${controller.loginUser.value.memberNickname}',
                        style: const TextStyle(fontSize: 20))),
                Row(
                  children: [
                    const Text('Nickname : ', style: TextStyle(fontSize: 20)),
                    SizedBox(
                      width: 170,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: nicknameController,
                          maxLength: 15,
                          decoration: const InputDecoration(
                            hintText: '  새로운 닉네임 입력',
                            hintStyle: TextStyle(fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[700], // Background color
                      ),
                      onPressed: () {
                        controller.changeNickname(nicknameController.text);
                        FocusScope.of(context).unfocus();
                      },
                      child: const Text(
                        '적용',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
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
                      UserController.to.logOut();
                    },
                  ),
                ),
              ]);
            },
          ),
        ),
      ),
    );
  }
}
