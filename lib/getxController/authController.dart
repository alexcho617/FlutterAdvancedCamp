// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<GoogleSignInAccount?> googleSignInAccount;

  late Rx<User?> firebaseUser;

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

    firebaseUser = Rx<User?>(auth.value.currentUser);
    firebaseUser.bindStream(auth.value.userChanges());

    // ever(googleSignInAccount, (_) {
    //   print("Google Sign In Changed!:\n");
    //   print(googleSignInAccount);
    //   print("\n\n");
    //   print("This is the value: \n");
    //   print(googleSignInAccount.value);
    // });
  }

  void register(String email, password) async {
    try{
      await auth.value.createUserWithEmailAndPassword(email: email, password: password);
    }catch(e){
      print("Error" + e.toString());
    }
  }

  void login(String email, password) async{
    try{
      await auth.value.signInWithEmailAndPassword(email: email, password: password);
    }catch(e){
      print("Error" + e.toString());
    }
  }

  void signOut() async {
    await auth.value.signOut();
  }

  void signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      //Get.snackbar("One", "signInDone", snackPosition: SnackPosition.TOP);

      //When google login success
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);

        await auth.value.signInWithCredential(authCredential);
        //Get.snackbar("Two", "signInCredentialDone", snackPosition: SnackPosition.BOTTOM);

        QuerySnapshot userQuerySnapshot = await firestore.collection('user').get();
        for (var element in userQuerySnapshot.docs) {
          if(element.id == auth.value.currentUser!.uid){
            return;
          }
        }
        setUser();

      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }


  CollectionReference user = FirebaseFirestore.instance.collection('user');
  Future<void> setUser(){

    return user.doc(auth.value.currentUser!.uid).set({
      'name' : auth.value.currentUser!.displayName,
      'email' : auth.value.currentUser!.email
    }).then((value) => print("User Logined\n")).catchError((e) =>print("Set Failed\n"));
  }

}
