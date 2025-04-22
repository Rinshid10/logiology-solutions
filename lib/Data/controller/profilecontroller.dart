import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var username = "admin".obs;
  var password = "Pass@123".obs;
  var profileImage = Rxn<File>();

  final ImagePicker _picker = ImagePicker();

  void changeUsername(String newUsername) {
    username.value = newUsername;
  }

  void changePassword(String newPassword) {
    password.value = newPassword;
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path);
    }
  }
}
