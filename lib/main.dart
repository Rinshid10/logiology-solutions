import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:logiology/View/Home/homepage.dart';
import 'package:logiology/View/loginscreen/loginpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: LoginPage(), debugShowCheckedModeBanner: false);
  }
}
