import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/user_controller.dart';

class FriendList extends StatelessWidget {
  FriendList({super.key});
  final userController = ;
  var ctr = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GetX<UserController>(builder: (controller) {
              return (controller.loginUser.value.friends == null)
                  ? const Text('data')
                  : ListView.builder(
                      itemCount: controller.loginUser.value.friends!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(controller.loginUser.value
                                              .friends![index].memberNickname),
                                          const Text('상태메시지')
                                        ],
                                      ),
                                      Image.network(controller.loginUser.value
                                          .friends![index].memberIcon)
                                    ],
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('대화하기'),
                                  ),
                                ]),
                          ),
                        );
                      },
                    );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('친구추가하기'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.green[300],
      ),
    );
  }
}
