import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hemweb/app/modules/home/views/home_view.dart';
import 'package:hemweb/app/routes/app_pages.dart';
import 'package:hemweb/services/auth_service.dart';
import 'package:hemweb/widgets/footer.dart';

import '../controllers/root_controller.dart';

class RootView extends GetView<RootController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(builder: (context, delegate, currentRoute) {
      return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
        controller.constraints = Rx<BoxConstraints>(constraints);
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
                          delegate.toNamed(Routes.HOME);
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
                                print("delegate to CART");
                                delegate.toNamed(Routes.CART);
                              },
                              icon: Icon(Icons.shopping_cart_outlined)),
                          IconButton(
                              onPressed: () {
                                print('root_view: line 52 ${AuthService.to.isLoggedInValue}');
                                if (AuthService().isLoggedInValue == true) {
                                  delegate.toNamed(Routes.PROFILE);
                                } else if (AuthService().isLoggedInValue !=
                                    true) {
                                  delegate.toNamed(Routes.LOGIN);
                                }
                              },
                              icon: Icon(Icons.person_outlined)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: constraints.maxHeight * 1.8,
                width: constraints.maxWidth,
                child: GetRouterOutlet(
                  initialRoute: Routes.HOME,
                ),
              ),
              // child: GetRouterOutlet(
              //   initialRoute: Routes.HOME,
              // ),
            ),
            Footer(),
          ],
        );
      }));
    });
  }
}
