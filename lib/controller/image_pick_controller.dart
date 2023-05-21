import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImagePickController extends GetxController {
  static ImagePickController get to => Get.find();

  final imagePicker = ImagePicker().obs;

  Future<String?> _pickImage() async {
    var image = await ImagePickController.to.imagePicker.value.pickImage(
        source: ImageSource.gallery, imageQuality: 50, maxHeight: 150);
    if (image != null) {
      return image.path;
    }
    return null;
  }

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
