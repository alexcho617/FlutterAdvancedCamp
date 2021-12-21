// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hemweb/screens/home.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  void goToHome() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text('Login Page'),
              ElevatedButton(
                onPressed: () {
                  Get.to(HomePage());
                },
                child: Text('Go To Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
