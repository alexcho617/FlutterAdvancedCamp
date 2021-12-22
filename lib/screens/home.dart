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
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

const String testImageURL =
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80';
final List<String> imgList = [
  'https://firebasestorage.googleapis.com/v0/b/hemweb.appspot.com/o/bannerImage_1.jpeg?alt=media&token=e41cca75-d145-4c01-90a9-82e6ed3e24e3',
  'https://firebasestorage.googleapis.com/v0/b/hemweb.appspot.com/o/bannerImage_2.jpeg?alt=media&token=16ba8e60-ab07-4b2b-add5-90d7db72d3b3',
  'https://firebasestorage.googleapis.com/v0/b/hemweb.appspot.com/o/bannerImage_3.jpeg?alt=media&token=27fab347-c7df-4153-9941-51761918a1b4',
  'https://firebasestorage.googleapis.com/v0/b/hemweb.appspot.com/o/bannerImage_4.jpeg?alt=media&token=61be35f4-b8a4-4861-94a8-6761b2fe20cc',
  'https://firebasestorage.googleapis.com/v0/b/hemweb.appspot.com/o/bannerImage_5.jpeg?alt=media&token=f8c56d26-e3a0-4ade-9fa8-8385d0dacdf2',
  'https://firebasestorage.googleapis.com/v0/b/hemweb.appspot.com/o/bannerImage_6.jpeg?alt=media&token=b7ea05bb-1b46-4a6b-aac1-a59864dd4c56'
];


class HomePage extends GetView<ProductController> {
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
                              onPressed: () {}, icon: Icon(Icons.search)),
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
            constraints.maxWidth > 1000 ? returnGrid(4) : returnGrid(2),
          ],
        );
      }),
    );
  }

  Obx returnGrid(int gridCount) {
    return Obx(
      () => SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridCount,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 1.5),
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return Container(
            color: index.isOdd ? Colors.white : Colors.black12,
            height: 50.0,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(controller.productList[index].imageURL),
                  Text('${controller.productList[index].company}'),
                  Text('${controller.productList[index].name}'),
                  Text('${controller.productList[index].price}'),
                  TextButton(
                      onPressed: () {
                        cartController.addCart(controller.productList[index]);
                        //add to firebase user/cart
                      },
                      child: Text('Add Cart')),
                ],
              ),
            ),
          );
        }, childCount: controller.productList.length),
      ),
    );
  }
}
