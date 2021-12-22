// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:hemweb/model/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var productList = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    QuerySnapshot x = await firestore.collection('product').get();
    for (var element in x.docs) {
      productList.add(Product.fromSnapShot(element));
    }
  }
}
