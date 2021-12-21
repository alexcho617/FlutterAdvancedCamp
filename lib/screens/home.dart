import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hemweb/screens/cart.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text('Home Page'),
              Text('I made new branch'),
              ElevatedButton(
                onPressed: () {
                  Get.to(CartPage());
                },
                child: Text('Go To Cart'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
