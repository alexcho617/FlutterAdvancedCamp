import 'package:get/get.dart';
import 'package:hemweb/app/modules/cart/controllers/cart_controller.dart';

import '../controllers/root_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RootController>(
      () => RootController(),
    );
    Get.lazyPut<CartController>(
      () => CartController(),
    );
  }
}
