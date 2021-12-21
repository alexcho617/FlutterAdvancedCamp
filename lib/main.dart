import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hemweb/screens/home.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Advacned Camp HEM',
      home: HomePage(),

    );
  }
}
