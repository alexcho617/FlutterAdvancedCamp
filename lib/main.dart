import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'services/auth_service.dart';
import 'app/routes/app_pages.dart';
import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';

void main() async {
  configureApp();
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb == true) {
    await Firebase.initializeApp(
      //webonly
      options: FirebaseOptions(
        apiKey: "AIzaSyAWXKccNzcX1tSPcXYkKRXeonD2JsG1AFE", // Your apiKey
        appId: "1:114809887796:web:bf7b5f140ffe5e7e717e61", // Your appId
        messagingSenderId: "114809887796", // Your messagingSenderId
        projectId: "hemweb", // Your projectId
        storageBucket: 'gs://hemweb.appspot.com/',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(GetMaterialApp.router(
    title: "Flutter Advance Camp HEM",
    initialBinding: BindingsBuilder(() {
      Get.put(AuthService());
    }),
    getPages: AppPages.routes,
  ));
}
