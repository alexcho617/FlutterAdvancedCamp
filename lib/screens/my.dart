import 'dart:html';

import 'package:flutter/material.dart';
import 'package:hemweb/getxController/authController.dart';
import 'package:get/get.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    // print(authController.myuser.value.cart);
    // print(authController.myuser.value.email);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("현재 로그인된 사용자"),
            Text(authController.myuser.value.email)
          ],
        ),
      ),
    );
  }
}
