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
        apiKey: "AIzaSyD3HEMEloUw73V1mvxtI71Ezyngj1s52vc", // Your apiKey
        appId: "1:275417015156:web:ddce8248173096a70dc221", // Your appId
        messagingSenderId: "275417015156", // Your messagingSenderId
        projectId: "boilerplate-8f1db", // Your projectId
        storageBucket: "boilerplate-8f1db.appspot.com",
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
    // navigatorObservers: <NavigatorObserver> [FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)],
  ));
}
