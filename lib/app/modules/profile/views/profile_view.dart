import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';
import '../../../../services/auth_service.dart';
class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProfileView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'ProfileView is working',
              style: TextStyle(fontSize: 20),
            ),
            TextButton(onPressed: (){
              AuthService().logout();
            }, child: Text('Logout'))
          ],
        ),
      ),
    );
  }
}
