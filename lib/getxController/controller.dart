import 'package:get/get.dart';
import 'package:hemweb/model/product.dart';

//define the getx controllers here
class CartController extends GetxController {
  // List<Product> cartList = [Product(name: 'Jeans',price: '59000')];
  List<Product> cartList = [];

  addCart(Product item) {
    cartList.add(item);
    update();
  }
}
