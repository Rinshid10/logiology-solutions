import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:logiology/View/Home/homepage.dart';

class Logincontroller extends GetxController {
  TextEditingController usernameControlller = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // predefined username and password
  var username = 'admin'.obs;
  var password = 'Pass@123'.obs;

  // the main login to controll the username and password
  void loginCheck(BuildContext context) {
    print('Entered username: ${usernameControlller.text}');
    print('Expected username: ${username.value}');
    print('Entered password: ${passwordController.text}');
    print('Expected password: ${password.value}');

    if (usernameControlller.text.trim() == username.value.trim() &&
        passwordController.text.trim() == password.value.trim()) {
      // Get.snackbar('Success', 'Login successful');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      Get.snackbar('Failed', 'Invalid credentials');
    }
  }
}
