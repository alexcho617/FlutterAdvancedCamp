// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<GoogleSignInAccount?> googleSignInAccount;

  @override
  void onInit(){
    super.onInit();

  }

  final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
  Rx<FirebaseAuth> auth = FirebaseAuth.instance.obs;
  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onReady() {
    super.onReady();
    googleSignInAccount = Rx<GoogleSignInAccount?>(googleSignIn.currentUser);
    googleSignInAccount.bindStream(googleSignIn.onCurrentUserChanged);

    ever(googleSignInAccount, (_) {
      print(googleSignInAccount);
    });
  }

  void signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      //When google login success
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);

        await auth.value.signInWithCredential(authCredential);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void authTestPrint() {
    print(auth);
  }
}
