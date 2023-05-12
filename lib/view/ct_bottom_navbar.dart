import 'package:come_together2/controller/main_page_contoller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CTBottomNavgationBar extends GetView<MainPageContoller> {
  const CTBottomNavgationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changeIndex,
          selectedItemColor: context.theme.colorScheme.onBackground,
          unselectedItemColor: context.theme.colorScheme.onSurfaceVariant,
          backgroundColor: Colors.green[300],
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.group,
                  color: (controller.selectedIndex.value == 0)
                      ? Colors.blue
                      : Colors.white54,
                ),
                label: "친구 목록"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.playlist_add_check,
                  color: (controller.selectedIndex.value == 1)
                      ? Colors.blue
                      : Colors.white54,
                ),
                label: "모집글 목록"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  color: (controller.selectedIndex.value == 2)
                      ? Colors.blue
                      : Colors.white54,
                ),
                label: "설정"),
          ],
        ));
  }
}
