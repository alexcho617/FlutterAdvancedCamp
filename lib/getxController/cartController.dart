// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:hemweb/model/product.dart';

//define the getx controllers here
class CartController extends GetxController {
  var cartList = <Product>[].obs;
  var checkList = <String>[].obs;
  var allCheck = false;

  // Future<void> fetchFirestore()async {
  //   await
  // }
  addCart(Product item) {
    if(!cartList.contains(item)){
      item.isChecked = false;
      cartList.add(item);
      Get.snackbar('장바구니', '장바구니에 담겼습니다.',snackPosition: SnackPosition.BOTTOM);
    }
    else{
      Get.snackbar('장바구니', '이미 장바구니에 존재하는 상품입니다.',snackPosition: SnackPosition.BOTTOM);
    }

  }

  void itemChange (bool value, int index) {
    cartList[index].isChecked = value;
    update();
  }
  void allChange (bool value) {
    allCheck = value;
    for(var item in cartList){
      item.isChecked = value;
      if(!checkList.contains(item.id))
      checkList.add(item.id);
    }
    update();
  }
}
