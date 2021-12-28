import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hemweb/app/modules/home/views/home_view.dart';
import 'package:hemweb/app/routes/app_pages.dart';

import '../controllers/root_controller.dart';

class RootView extends GetView<RootController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetRouterOutlet(
        initialRoute: Routes.HOME,
      ),
    );
  }
}
