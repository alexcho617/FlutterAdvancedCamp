import 'dart:math';

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hemweb/app/modules/cart/controllers/cart_controller.dart';
import 'package:hemweb/app/modules/products/controllers/products_controller.dart';
import 'package:hemweb/app/routes/app_pages.dart';

import 'package:hemweb/models/product.dart';
import '../models/user.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  Rx<CustomUser> myuser = CustomUser().obs;
  Rx<FirebaseAuth> auth = FirebaseAuth.instance.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference user = FirebaseFirestore.instance.collection('Hiver/user/Users');
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  /// Mocks a login process

  final isLoggedIn = false.obs;
  bool get isLoggedInValue => isLoggedIn.value;

  @override
  void onReady() async{//여기서 실행하는 것은 잘안된다 왜지..?
    super.onReady();
    authCheck();
  }

  Future<User?> authCheck() async {
    User? user = await auth.value.authStateChanges().first;
    if(user != null){
      isLoggedIn.value = true;
      fetchUser();
    }
    return user;
  }

  void login(String email, String password) async {
    print("login called");
    print(auth.value.currentUser);
    try {
      await auth.value
          .signInWithEmailAndPassword(email: email, password: password);
      if (auth.value.currentUser != null) {
        await analytics.logLogin();
        //await analytics.setUserId(id: auth.value.currentUser!.uid);
        await analytics.logScreenView();
        await analytics.setUserProperty(name: 'name', value: '5');
        isLoggedIn.value = true;
        fetchUser();
        //Get.rootDelegate.toNamed(Routes.HOME);
        final thenTo = Get.rootDelegate.currentConfiguration!.currentPage!
            .parameters?['then'];
        Get.rootDelegate.offNamed(thenTo ?? Routes.HOME);
        Get.snackbar("login", 'login success');
      } else {
        Get.snackbar('login', 'login fail');
      }
    } catch (e) {
      print("Error" + e.toString());
      Get.snackbar('login', 'login fail');
    }
  }

  void logout() async {
    final cartController = Get.find<CartController>();
    isLoggedIn.value = false;
    await auth.value.signOut();
    myuser.value.cart = [];
    cartController.cartList.clear();
  }

  void register(String email, password) async {
    try {
      await auth.value
          .createUserWithEmailAndPassword(email: email, password: password);
      isLoggedIn.value = true;
      setUser();
      Get.rootDelegate.toNamed(Routes.HOME);
      Get.snackbar("sign up", 'register success');
    } catch (e) {
      print("Error" + e.toString());
      Get.snackbar('register', e.toString());
    }
  }

  Future<void> setUser() {
    //auth to state
    myuser.value.email = auth.value.currentUser!.email;
    myuser.value.cart = [];

    //state to db
    return user
        .doc(auth.value.currentUser!.uid)
        .set({'email': myuser.value.email, 'cart': myuser.value.cart})
        .then((value) => print("User Logined\n"))
        .catchError((e) => print("Set Failed\n"));
  }

  Future<Rx<CustomUser>> fetchUser() async {
    var productController = Get.find<ProductsController>();
    var cartController = Get.find<CartController>();

    //fetch user info from db
    DocumentSnapshot userSnapshot = await firestore
        .collection('Hiver/user/Users')
        .doc(auth.value.currentUser!.uid)
        .get();
    myuser.value.email = auth.value.currentUser!.email;
    List<dynamic> cartSnapshot = userSnapshot['cart'];

    //productController.productList

    for (String i in cartSnapshot) {
      for (Product j in productController.productList) {
        if (i == j.id) {
          cartController.addCart(j, 0);
        }
      }
    }
    print("fetch success! current cart item id: " + cartSnapshot.toString());
    myuser.value.cart = cartController.cartList;

    return myuser;
  }
}
