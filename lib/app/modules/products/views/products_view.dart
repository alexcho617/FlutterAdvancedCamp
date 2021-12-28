import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 359,
              autoPlay: true,
            ),
            items: imgList
                .map((item) => Container(
                      color: Colors.blue,
                      child: Image.network(
                        item,
                        fit: BoxFit.fitWidth,
                      ),
                    ))
                .toList(),
          ),
          SizedBox(
            height: 60,
          ),
          Text("Gridview Here"),
        ],
      )),
    );
  }
}
