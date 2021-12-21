// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:hemweb/model/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var productList = <Product>[].obs;

  Future<void> fetchProducts() async {
    await firestore
        .collection('product')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        Product prodObject = Product();
        prodObject.name = doc.get("name").toString();
        prodObject.price = doc.get("price").toString();
        prodObject.company = doc.get("brand").toString();
        prodObject.imageURL = doc.get("image").toString();
        productList.add(prodObject);
      }
    });
  }

  void printProduct() {
    print('printProd called');
    print('prodList length: ${productList.length}');
    for (var prod in productList) {
      print(prod.name);
      print(prod.price);
    }
  }
}
