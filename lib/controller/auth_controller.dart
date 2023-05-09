import 'package:come_together2/pages/first_page.dart';
import 'package:come_together2/pages/login_main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth authentication = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(authentication.currentUser);
    _user.bindStream(authentication.userChanges());
    ever(_user, _moveToPage);
  }

  void _moveToPage(User? user) {
    if (user == null) {
      Get.offAll(() => const FirstPage());
    } else {
      Get.offAll(() => LoginMain());
    }
  }

  void logout() {
    authentication.signOut();
  }
}
