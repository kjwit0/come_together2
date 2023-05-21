import 'package:get/get.dart';

class MainPageContoller extends GetxController {
  static MainPageContoller get to => Get.find();

  final RxInt selectedIndex = 1.obs;

  void changeIndex(int index) {
    selectedIndex(index);
  }
}
