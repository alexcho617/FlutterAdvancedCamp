// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:hemweb/getxController/authController.dart';
import 'package:hemweb/model/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//define the getx controllers here
class CartController extends GetxController {
  var cartList = <Product>[].obs;
  var checkList = <String>[].obs;
  var allCheck = false;
  CollectionReference userReference =
      FirebaseFirestore.instance.collection('user');
  @override
  void onInit() {
    super.onInit();
    var authController = Get.find<AuthController>();
    //Obx Worker: Listen To Change in Cart
    ever(cartList, (_) async {
      await userReference
          .doc(authController.auth.value.currentUser?.uid)
          .update({
        'cart': toIndexList(cartList),
      });
    });
  }

  List<String> toIndexList(List<Product> cartList) {
    List<String> cartSnapshot = [];
    for (Product item in cartList) {
      cartSnapshot.add(item.id);
    }
    return cartSnapshot;
  }

  addCart(Product item, int option) {
    if (!cartList.contains(item)) {
      if (option == 1) {
        Get.snackbar('장바구니', '장바구니에 담겼습니다.',
            snackPosition: SnackPosition.BOTTOM);
      }
      item.isChecked = false;
      cartList.add(item);
    } else {
      Get.snackbar('장바구니', '이미 장바구니에 존재하는 상품입니다.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void itemChange(bool value, int index) {
    cartList[index].isChecked = value;
    update();
  }

  void allChange(bool value) {
    allCheck = value;
    for (var item in cartList) {
      item.isChecked = value;
      if (!checkList.contains(item.id)) checkList.add(item.id);
    }
    update();
  }
}
