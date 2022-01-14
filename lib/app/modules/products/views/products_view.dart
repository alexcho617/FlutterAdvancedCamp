import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hemweb/app/modules/cart/controllers/cart_controller.dart';
import 'package:hemweb/app/modules/root/controllers/root_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hemweb/app/routes/app_pages.dart';
import 'package:hemweb/services/auth_service.dart';
import 'package:hemweb/widgets/footer.dart';

import '../controllers/products_controller.dart';

final List<String> imgList = [
  'https://firebasestorage.googleapis.com/v0/b/hemweb.appspot.com/o/bannerImage_1.jpeg?alt=media&token=e41cca75-d145-4c01-90a9-82e6ed3e24e3',
  'https://firebasestorage.googleapis.com/v0/b/hemweb.appspot.com/o/bannerImage_2.jpeg?alt=media&token=16ba8e60-ab07-4b2b-add5-90d7db72d3b3',
  'https://firebasestorage.googleapis.com/v0/b/hemweb.appspot.com/o/bannerImage_3.jpeg?alt=media&token=27fab347-c7df-4153-9941-51761918a1b4',
  'https://firebasestorage.googleapis.com/v0/b/hemweb.appspot.com/o/bannerImage_4.jpeg?alt=media&token=61be35f4-b8a4-4861-94a8-6761b2fe20cc',
  'https://firebasestorage.googleapis.com/v0/b/hemweb.appspot.com/o/bannerImage_5.jpeg?alt=media&token=f8c56d26-e3a0-4ade-9fa8-8385d0dacdf2',
  'https://firebasestorage.googleapis.com/v0/b/hemweb.appspot.com/o/bannerImage_6.jpeg?alt=media&token=b7ea05bb-1b46-4a6b-aac1-a59864dd4c56'
];

class ProductsView extends GetView<ProductsController> {
  final rootController = Get.find<RootController>();
  final authController = Get.find<AuthService>();
  final cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: rootController.constraints.value.maxWidth < 1000
                  ? rootController.constraints.value.maxWidth * 0.4
                  : 400,
              autoPlay: true,
            ),
            items: imgList
                .map((item) => Container(
                      color: Colors.blue,
                      child: Image.network(
                        item,
                        fit: BoxFit.cover,
                      ),
                    ))
                .toList(),
          ),
          SizedBox(
            height: 60,
          ),
          rootController.constraints.value.maxWidth > 1000
              ? returnGrid(4, rootController.constraints.value)
              : returnGrid(2, rootController.constraints.value),
        ],
      ),
    );
  }

  Obx returnGrid(int gridCount, BoxConstraints constraints) {
    bool isWideLayout;
    if (gridCount == 4) {
      isWideLayout = true;
    } else {
      isWideLayout = false;
    }

    return Obx(
      () => GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridCount,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 0.75),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            width: gridCount == 2
                ? constraints.maxWidth * 0.5
                : constraints.maxWidth * 0.2,
            height: constraints.maxHeight * 0.2,
            color: Colors.white,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Image.network(
                      controller.productList[index].imageURL,
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${controller.productList[index].company}',
                            style: TextStyle(color: Colors.grey),
                          ),
                          RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            text: TextSpan(
                              text: controller.productList[index].name,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            '₩${controller.productList[index].price}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () async {
                      //var cartController = Get.find<CartController>();
                      //var authController = Get.find<AuthController>();
                      //add to firebase user/cart
                      AuthService.to.analytics.logAddToCart(
                        items: [
                          AnalyticsEventItem(
                              itemName: 'Socks',
                              itemId: 'xjw73ndnw',
                              price: 10.0),
                        ],
                        currency: 'KRW',
                        value: 15,
                      );
                      if (AuthService.to.isLoggedInValue != false) {
                        cartController.addCart(
                            controller.productList[index], 1);
                        DocumentReference userReference = FirebaseFirestore
                            .instance
                            .collection('Hiver/user/Users')
                            .doc(AuthService.to.auth.value.currentUser!.uid);
                        await userReference.update({
                          'cart': FieldValue.arrayUnion(
                              [controller.productList[index].id])
                        }).then((value) => print("Cart added in DB"));
                      } else {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('로그인'),
                            content: const Text('장바구니에 상품을 담으려면 로그인을 하셔야 합니다.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Get.back(),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                  Get.rootDelegate.toNamed(Routes.LOGIN);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: controller.productList.length,
      ),
    );
  }
}
