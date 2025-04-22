import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

class Logincontroller extends GetxController {
  TextEditingController usernameControlller = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // predefined username and password
  var username = 'admin'.obs;
  var password = 'Pass@123'.obs;

  // the main login to controll the username and password
  void loginCheck() {
    if (usernameControlller.text == username.value &&
        passwordController.text == password.value) {
      Get.snackbar('succes', 'you can enter');
    } else {
      Get.snackbar('failed', 'you canot enter');
    }
  }
}
