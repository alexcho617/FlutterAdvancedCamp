import 'package:get/get.dart';
import 'package:hemweb/app/modules/cart/controllers/cart_controller.dart';

import '../controllers/products_controller.dart';

class ProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductsController>(
      () => ProductsController(),
    );
    Get.lazyPut<CartController>(
      () => CartController(),
    );
  }
}
