// ignore_for_file: file_names
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:get/get.dart';
import 'package:hemweb/model/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }
  // @override
  // void onClose() {

  //   super.onClose();
  // }
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var productList = <Product>[].obs;
  //factory

  @override
  void getOnInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    QuerySnapshot x = await firestore.collection('product').get();

    x.docs.forEach((element) async {
      productList.add(Product.fromSnapShot(element));
    });

    // await firestore
    //     .collection('product')
    //     .get()
    //     .then((QuerySnapshot querySnapshot) {
    //   for (var doc in querySnapshot.docs) {
    //     Product prodObject = Product();
    //     prodObject.name = doc.get("name").toString();
    //     prodObject.price = doc.get("price").toString();
    //     prodObject.company = doc.get("brand").toString();
    //     prodObject.imageURL = doc.get("image").toString();
    //     productList.add(prodObject);
    //   }
    // });
  }

  void printProduct() async{
    print('printProd called');
    print('prodList length: ${productList.length}');
    for (var prod in productList) {
      print(prod.name);
      print(prod.price);
    }
  }
}
