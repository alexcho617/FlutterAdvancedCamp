import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hemweb/app/modules/cart/controllers/cart_controller.dart';
import 'package:hemweb/app/modules/products/controllers/products_controller.dart';
import 'package:hemweb/app/routes/app_pages.dart';

import 'package:hemweb/models/product.dart';
import '../models/user.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  Rx<CustomUser> myuser = CustomUser().obs;
  Rx<FirebaseAuth> auth = FirebaseAuth.instance.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference user = FirebaseFirestore.instance.collection('user');

  /// Mocks a login process
  final isLoggedIn = false.obs;
  bool get isLoggedInValue => isLoggedIn.value;

  @override
  void onReady() {
    super.onReady();
    authCheck();
  }

  void authCheck() async {

    if(auth.value.authStateChanges().first != null){//TODO: 문제가 있다...여기에 그냥 무작정실행되네.
      await auth.value.authStateChanges().first.then((value) {
          print('Auth_service: line 33 $value');
          if(auth.value.currentUser != null){
          isLoggedIn.value = true;
          fetchUser();
          }
        }
      );
    }
    // if(fetchUser() != null){
    //   isLoggedInValue = true;
    // }
    // if(fetchUser() != null){
    //  isLoggedIn.value = true;
    // }
  }

  void login(String email, String password) async {
    print("login called");
    try {
      await auth.value
          .signInWithEmailAndPassword(email: email, password: password);
      if (auth.value.currentUser != null) {
        isLoggedIn.value = true;
        fetchUser();
        //Get.rootDelegate.toNamed(Routes.HOME);
        final thenTo = Get.rootDelegate.currentConfiguration!
                    .currentPage!.parameters?['then'];
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
    await auth.value.signOut();
    myuser.value.cart = [];
    cartController.cartList.clear();
    isLoggedIn.value = false;
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
    DocumentSnapshot userSnapshot = await firestore.collection('user').doc(auth.value.currentUser!.uid).get();
    myuser.value.email = auth.value.currentUser!.email;
    List<dynamic> cartSnapshot = userSnapshot['cart'];

    //productController.productList

    for(String i in cartSnapshot) {
      for (Product j in productController.productList) {
        if (i == j.id) {
          cartController.addCart(j, 0);
        }
      }
    }
    print("fetch success! current cart item id: "+ cartSnapshot.toString());
    myuser.value.cart = cartController.cartList;

    return myuser;
  }

}


