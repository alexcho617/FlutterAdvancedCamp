import 'package:get/get.dart';

import '../controllers/test01_controller.dart';

class Test01Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Test01Controller>(
      () => Test01Controller(),
    );
  }
}
