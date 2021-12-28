import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/test01_controller.dart';

class Test01View extends GetView<Test01Controller> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Text("Hello"),
    );
  }
}
