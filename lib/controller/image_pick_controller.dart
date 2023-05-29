import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

/// 스마트폰 내부의 이미지를 로드
class ImagePickController extends GetxController {
  static ImagePickController get to => Get.find();

  final imagePicker = ImagePicker().obs;

  /// 이미지 선택
  Future<String?> _pickImage() async {
    var image = await ImagePickController.to.imagePicker.value.pickImage(
        source: ImageSource.gallery, imageQuality: 50, maxHeight: 150);

    if (image != null) {
      return image.path;
    }
    return null;
  }

  /// 이미지 firebase db에 업로드
  Future<String?> uploadImage() async {
    String? url;
    await _pickImage().then((value) async {
      if (value != null) {
        var userIcons = FirebaseStorage.instance
            .ref()
            .child('userIcon')
            .child('${FirebaseAuth.instance.currentUser!.uid}.png');

        await userIcons.putFile(File(value));
        url = await userIcons.getDownloadURL();
      }
    });
    return url;
  }
}
