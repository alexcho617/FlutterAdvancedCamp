import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hemweb/screens/cart.dart';
import 'package:hemweb/screens/login.dart';
import 'package:hemweb/screens/my.dart';

import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';
import 'package:hemweb/getxController/productController.dart';
import 'package:hemweb/screens/home.dart';

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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => GetMaterialApp(
        title: 'Flutter Advacned Camp HEM',
        initialBinding: BindingsBuilder(() {
          Get.put(ProductController());
        }),
        //home: HomePage(),
        // home: ResponsivePage()
        initialRoute: '/Home',
        getPages: [
          GetPage(name: '/Home', page: () => HomePage()),
          GetPage(name: '/Login', page: () => LoginPage()),
          GetPage(name: '/Profile', page: () => MyPage()),
          GetPage(name: '/Cart', page: () => CartPage())
        ],
      ),
      designSize: const Size(414, 896),

      // BoxConstraints(
      //       maxWidth: MediaQuery.of(context).size.width,
      //       maxHeight: MediaQuery.of(context).size.height),
      //   designSize: Size(414, 896),
      //   orientation: Orientation.portrait
    );
  }
}
