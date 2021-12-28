import 'package:get/get.dart';

import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/products/bindings/products_binding.dart';
import '../modules/products/views/products_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/root/bindings/root_binding.dart';
import '../modules/root/views/root_view.dart';
import '../modules/test01/bindings/test01_binding.dart';
import '../modules/test01/views/test01_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
        name: '/',
        page: () => RootView(),
        binding: RootBinding(),
        participatesInRootNavigator: true,
        preventDuplicates: true,
        children: [
          GetPage(
              name: _Paths.HOME,
              page: () => HomeView(),
              binding: HomeBinding(),
              children: [
                GetPage(
                  name: _Paths.PRODUCTS,
                  page: () => ProductsView(),
                  binding: ProductsBinding(),
                ),
                GetPage(
                  name: _Paths.PROFILE,
                  page: () => ProfileView(),
                  binding: ProfileBinding(),
                ),
              ]),
          GetPage(
            name: _Paths.CART,
            page: () => CartView(),
            binding: CartBinding(),
          ),
          GetPage(
            name: _Paths.LOGIN,
            page: () => LoginView(),
            binding: LoginBinding(),
          ),
        ]),
    GetPage(
      name: _Paths.TEST01,
      page: () => Test01View(),
      binding: Test01Binding(),
    ),
  ];
}
