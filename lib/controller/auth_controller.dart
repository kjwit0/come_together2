import 'package:come_together2/pages/first_page.dart';
import 'package:come_together2/pages/login_main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// 인증 관련 컨트롤러
class AuthController extends GetxController {
  static AuthController to = Get.find();
  late Rx<User?> user;
  FirebaseAuth authentication = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    user = Rx<User?>(authentication.currentUser);
    user.bindStream(authentication.userChanges());
    ever(user, _moveToPage);
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    return null;
  }

  void _moveToPage(User? user) {
    if (user == null) {
      Get.offAll(() => const FirstPage());
    } else {
      Get.off(() => LoginMain());
    }
  }

  void logout() {
    Get.offAll(() => const FirstPage())!.then((value) {
      authentication.signOut();
    });
  }
}
