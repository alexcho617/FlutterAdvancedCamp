// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hemweb/getxController/cartController.dart';
import 'package:hemweb/getxController/productController.dart';
import 'package:hemweb/models/user.dart';
import 'package:hemweb/models/product.dart';
import 'package:hemweb/screens/home.dart';

enum LoginState{
  loggedIn,
  loggedOut
}

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<GoogleSignInAccount?> googleSignInAccount;
  Rx<CustomUser> myuser = CustomUser().obs;

  LoginState loginState = LoginState.loggedOut;

  @override
  void onInit(){
    super.onInit();

  }

  Rx<FirebaseAuth> auth = FirebaseAuth.instance.obs;
  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onReady() {
    super.onReady();
    googleSignInAccount = Rx<GoogleSignInAccount?>(googleSignIn.currentUser);
    googleSignInAccount.bindStream(googleSignIn.onCurrentUserChanged);
  }

  void register(String email, password) async {
    try{
      await auth.value.createUserWithEmailAndPassword(email: email, password: password);
      loginState = LoginState.loggedIn;
      setUser();
      Get.to(HomePage());
      Get.snackbar("sign up", 'register success');
    }catch(e){
      print("Error" + e.toString());
      Get.snackbar('register', e.toString());
    }
  }

  void login(String email, password) async{
    try{
      await auth.value.signInWithEmailAndPassword(email: email, password: password);
      if(auth.value.currentUser != null){
        loginState = LoginState.loggedIn;
        fetchUser();
        Get.to(HomePage());
        Get.snackbar("login", 'login success');
      }else{
        Get.snackbar('login', 'login fail');
      }
    }catch(e){
      print("Error" + e.toString());
      Get.snackbar('login', 'login fail');
    }
  }

  void signOut() async {
    await auth.value.signOut();
    myuser.value.cart = [];
    loginState = LoginState.loggedOut;
  }

  void signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        await auth.value.signInWithCredential(authCredential);
        QuerySnapshot userQuerySnapshot = await firestore.collection('user').get();
        for (var element in userQuerySnapshot.docs) {
          if(element.id == auth.value.currentUser!.uid){
            return;
          }
        }
        setUser();
        loginState = LoginState.loggedIn;
        Get.to(HomePage());
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }


  CollectionReference user = FirebaseFirestore.instance.collection('user');
  Future<void> setUser(){
    //auth to state
    myuser.value.email = auth.value.currentUser!.email;
    myuser.value.cart = [];


    //state to db
    return user.doc(auth.value.currentUser!.uid).set({
      'email' : myuser.value.email,
      'cart' : myuser.value.cart
    }).then((value) => print("User Logined\n")).catchError((e) =>print("Set Failed\n"));
  }

  Future<Rx<CustomUser>> fetchUser() async {
    var cartController = Get.find<CartController>();
    var productController = Get.find<ProductController>();

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
