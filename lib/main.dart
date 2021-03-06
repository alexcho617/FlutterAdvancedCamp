import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hemweb/app/modules/cart/controllers/cart_controller.dart';
import 'package:hemweb/app/modules/products/controllers/products_controller.dart';



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
        // measurementId: "G-W2LZ1X52Z3"//to use GA
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(GetMaterialApp.router(
    title: "Flutter Advance Camp HEM",
    initialBinding: BindingsBuilder(() {
      Get.put(AuthService());
      Get.put(ProductsController());
      Get.put(CartController());

    }),
    getPages: AppPages.routes,
    navigatorObservers: <NavigatorObserver> [FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)],
  ));
}
