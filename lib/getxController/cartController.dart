import 'package:get/get.dart';
import 'package:hemweb/model/product.dart';


//define the getx controllers here
class CartController extends GetxController {
  var cartList = <Product>[].obs;
  var checkList = <String>[].obs;

  addCart(Product item) async {
    cartList.add(item);
    Get.snackbar('장바구니', '장바구니에 담겼습니다.',snackPosition: SnackPosition.BOTTOM);
  }

}
