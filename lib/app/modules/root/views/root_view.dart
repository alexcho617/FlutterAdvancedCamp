import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hemweb/app/modules/home/views/home_view.dart';
import 'package:hemweb/app/routes/app_pages.dart';

import '../controllers/root_controller.dart';

class RootView extends GetView<RootController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(builder: (context, delegate, current) {
      return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
        return CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              pinned: true,
              snap: true,
              floating: true,
              expandedHeight: constraints.maxHeight * 0.05,
              flexibleSpace: FlexibleSpaceBar(
                title: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed("/Home");
                        },
                        child: Image.asset(
                          'assets/logoImage.png',
                          height: 30,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.search)),
                          IconButton(
                              onPressed: () {
                                Get.rootDelegate.toNamed(Routes.CART);
                              },
                              icon: Icon(Icons.shopping_cart_outlined)),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.person_outlined)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GetRouterOutlet(initialRoute: Routes.TEST01),
            SliverToBoxAdapter(
              child: SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight * 0.5,
                child: GetRouterOutlet(
                  initialRoute: Routes.HOME,
                ),
              ),
            )
          ],
        );
      }));
    });
  }
}
