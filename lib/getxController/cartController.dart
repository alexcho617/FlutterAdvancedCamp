// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:hemweb/model/product.dart';

//define the getx controllers here
class CartController extends GetxController {

  var cartList = <Product>[].obs;
  var checkList = <String>[].obs;

  // Future<void> fetchFirestore()async {
  //   await 
  // }
  addCart(Product item) {
    cartList.add(item);
  }

}
