import 'package:get/get.dart';

///bottom navigator 동작
class MainPageContoller extends GetxController {
  static MainPageContoller get to => Get.find();

  final RxInt selectedIndex = 1.obs;

  void changeIndex(int index) {
    selectedIndex(index);
  }
}
