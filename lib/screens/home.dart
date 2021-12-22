// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hemweb/getxController/authController.dart';
import 'package:hemweb/getxController/cartController.dart';
import 'package:hemweb/getxController/productController.dart';
import 'package:hemweb/model/product.dart';
import 'package:hemweb/screens/cart.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hemweb/screens/login.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class HomePage extends GetView<ProductController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    // final productController = Get.put(ProductController());

    // productController.fetchProducts();

    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) =>
            CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              pinned: true,
              snap: false,
              floating: true,
              expandedHeight: 160.0,
              flexibleSpace: FlexibleSpaceBar(
                //header

                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/logoImage.png',
                        height: 30,
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Get.to(CartPage());
                              },
                              icon: Icon(Icons.shopping_cart_outlined)),
                          IconButton(
                              onPressed: () {
                                Get.to(LoginPage());
                              },
                              icon: Icon(Icons.person_outlined)),
                        ],
                      ),
                    ],
                  ),
                ),
                // background: FlutterLogo(),
              ),
            ),
            //dropdown menu
            SliverToBoxAdapter(
              child: Container(
                height: 50,
                color: Colors.white,
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.to(CartPage());
                      },
                      child: Text('Go To Cart'),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.printProduct();
                      },
                      child: Text('Print Product'),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.fetchProducts();
                      },
                      child: Text('Fetch Product'),
                    ),
                  ],
                ),
              ),
            ),
            //slider
            SliverToBoxAdapter(
              child: Container(
                  child: CarouselSlider(
                options: CarouselOptions(
                  height: 400,
                  autoPlay: true,
                ),
                items: imgList
                    .map((item) => Container(
                          child: Center(
                              child: Image.network(item,
                                  fit: BoxFit.cover, width: 1000)),
                        ))
                    .toList(),
              )),
            ),
            //items

            Obx(() => SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250.0,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 1.5,
                  ),
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Container(
                      color: index.isOdd ? Colors.white : Colors.black12,
                      height: 300.0,
                      child: Center(
                        child: Column(
                          children: [
                            Text('${controller.productList[index].name}'),
                            // Text('${productList[index].price}'),
                            TextButton(
                                onPressed: () {
                                  cartController
                                      .addCart(controller.productList[index]);
                                  //add to firebase user/cart
                                },
                                child: Text('Add Cart')),
                          ],
                        ),
                      ),
                    );
                  }, childCount: controller.productList.length),
                ))
          ],
        ),
      ),
    );
  }
}



// productController.productList.length == 0
//                   ? CircularProgressIndicator()
//                   : 