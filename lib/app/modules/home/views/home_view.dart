import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hemweb/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(builder: (context, delegate, currentRoute) {
      return Scaffold(
        body: SizedBox(
          width: 1000,
          height: 2000,
          child: GetRouterOutlet(
            initialRoute: Routes.PRODUCTS,
            key: Get.nestedKey(Routes.HOME),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          // key: UniqueKey(),
          currentIndex: 0,
          onTap: (value) {
            switch (value) {
              case 0:
                delegate.toNamed(Routes.HOME);
                break;
              case 1:
                delegate.toNamed(Routes.CART);
                break;
              case 2:
                delegate.toNamed(Routes.LOGIN);
                break;
              default:
            }
          },
          items: [
            // _Paths.HOME + [Empty]
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            // _Paths.HOME + Routes.PROFILE
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box_rounded),
              label: 'Profile',
            ),
            // _Paths.HOME + _Paths.PRODUCTS
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box_rounded),
              label: 'Products',
            ),
          ],
        ),
      );
    });
  }
}
