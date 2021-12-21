import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hemweb/screens/home.dart';
import 'package:hemweb/screens/login.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase_core.Firebase.initializeApp();
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
