// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hemweb/getxController/authController.dart';
import 'package:hemweb/getxController/cartController.dart';
import 'package:hemweb/getxController/productController.dart';
import 'package:hemweb/model/product.dart';
import 'package:hemweb/screens/cart.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hemweb/screens/login.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:hemweb/screens/my.dart';
import 'package:hemweb/widgets/footer.dart';

final List<String> imgList = [
  'https://firebasestorage.googleapis.com/v0/b/hemweb.appspot.com/o/bannerImage_1.jpeg?alt=media&token=e41cca75-d145-4c01-90a9-82e6ed3e24e3',
  'https://firebasestorage.googleapis.com/v0/b/hemweb.appspot.com/o/bannerImage_2.jpeg?alt=media&token=16ba8e60-ab07-4b2b-add5-90d7db72d3b3',
  'https://firebasestorage.googleapis.com/v0/b/hemweb.appspot.com/o/bannerImage_3.jpeg?alt=media&token=27fab347-c7df-4153-9941-51761918a1b4',
  'https://firebasestorage.googleapis.com/v0/b/hemweb.appspot.com/o/bannerImage_4.jpeg?alt=media&token=61be35f4-b8a4-4861-94a8-6761b2fe20cc',
  'https://firebasestorage.googleapis.com/v0/b/hemweb.appspot.com/o/bannerImage_5.jpeg?alt=media&token=f8c56d26-e3a0-4ade-9fa8-8385d0dacdf2',
  'https://firebasestorage.googleapis.com/v0/b/hemweb.appspot.com/o/bannerImage_6.jpeg?alt=media&token=b7ea05bb-1b46-4a6b-aac1-a59864dd4c56'
];

class HomePage extends GetView<ProductController> {
  final authController = Get.put(AuthController());
  final cartController = Get.put(CartController());
  bool? isNarrow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              pinned: true,
              snap: true,
              floating: true,
              expandedHeight: constraints.maxHeight * 0.05,
              flexibleSpace: FlexibleSpaceBar(
                //header

                title: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          Get.to(HomePage());
                        },
                        child: Image.asset(
                          'assets/logoImage.png',
                          height: constraints.maxHeight * 0.03,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.search)),
                          IconButton(
                              onPressed: () {
                                if(authController.loginState == LoginState.loggedOut){
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
                                            Get.to(LoginPage());
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                if(authController.loginState == LoginState.loggedIn) Get.to(CartPage());
                              },
                              icon: Icon(Icons.shopping_cart_outlined)),
                          IconButton(
                              onPressed: () {
                                //var authController = Get.find<AuthController>();
                                print(authController.loginState);
                                if (authController.loginState ==
                                    LoginState.loggedOut) Get.to(LoginPage());
                                if (authController.loginState ==
                                    LoginState.loggedIn) Get.to(MyPage());
                              },
                              icon: Icon(Icons.person_outlined)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //slider
            SliverToBoxAdapter(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: constraints.maxWidth < 1000 ? constraints.maxWidth* 0.4 : 400,
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
            ),
            //items
            constraints.maxWidth > 1000
                ? returnGrid(4, constraints)
                : returnGrid(2, constraints),
            //Footer
            Footer()
          ],
        );
      }),
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
      () => SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridCount,
            mainAxisSpacing: 10.0.h,
            crossAxisSpacing: 10.0.w,
            childAspectRatio: 0.75),
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0.w),
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
                      if (authController.loginState != LoginState.loggedOut) {
                        cartController.addCart(
                            controller.productList[index], 1);
                        DocumentReference userReference = FirebaseFirestore
                            .instance
                            .collection('user')
                            .doc(authController.auth.value.currentUser!.uid);
                        await userReference.update({
                          'cart': FieldValue.arrayUnion(
                              [controller.productList[index].id])
                        }).then((value) => print("Cart added in DB"));
                      } else {
                        // Get.defaultDialog(
                        //     onConfirm: () {
                        //       Get.to(LoginPage());
                        //     },
                        //     middleText: "장바구니에 상품을 담으려면 로그인을 하셔야 합니다."
                        //   AlertDialog(
                        //     title: Text('로그인'),
                        //     content: Text('장바구니에 상품을 담으려면 로그인을 하셔야 합니다.'),
                        //     actions: [
                        //       TextButton(onPressed: (){
                        //         Get.to(LoginPage());
                        //       }, child: Text('ok')),
                        //       TextButton(onPressed: (){
                        //         Get.back();
                        //       }, child: Text('cancel'))
                        //     ],
                        //   );
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
                                  Get.to(LoginPage());
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
        }, childCount: controller.productList.length),
      ),
    );
  }
}

