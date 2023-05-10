import 'package:get/get.dart';

class MainPageContoller extends GetxController {
  // Get.fine 대신 클래스명 사용 가능
  static MainPageContoller get to => Get.find();

  final RxInt selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex(index);
  }
}
