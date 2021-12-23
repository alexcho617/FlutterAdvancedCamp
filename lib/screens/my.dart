import 'package:flutter/material.dart';
import 'package:hemweb/getxController/authController.dart';
import 'package:get/get.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("현재 로그인된 사용자",style: Theme.of(context).textTheme.headline6,),
            Text(authController.myuser.value.email),
            SizedBox(height: 12.0),
            ElevatedButton(onPressed: (){
              authController.signOut();
              Get.back();
            }, child: Text("로그아웃"))
          ],
        ),
      ),
    );
  }
}
