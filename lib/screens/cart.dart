// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hemweb/screens/home.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:hemweb/getxController/authController.dart';
import 'package:hemweb/getxController/cartController.dart';
import 'package:hemweb/widgets/footer.dart';

import 'login.dart';
import 'my.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    return Scaffold(body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: constraints.maxHeight * 0.05,
            flexibleSpace: FlexibleSpaceBar(
              //header
              title: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(HomePage());
                      },
                      child: Image.asset(
                        'assets/logoImage.png',
                        height: constraints.maxHeight * 0.03,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                        IconButton(
                            onPressed: () {
                              //Get.to(CartPage());
                            },
                            icon: Icon(Icons.shopping_cart_outlined)),
                        IconButton(
                            onPressed: () {
                              var authController = Get.find<AuthController>();
                              print(authController.loginState);
                              if (authController.loginState ==
                                  LoginState.loggedOut) Get.to(LoginPage());
                              if (authController.loginState ==
                                  LoginState.loggedIn) Get.to(MyPage());
                            },
                            icon: Icon(Icons.person_outlined)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0, top: 30),
                      child: Text(
                        '장바구니',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Divider(
                      height: 50,
                      indent: 0,
                      endIndent: 0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 50),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  GetBuilder<CartController>(
                                    builder: (_) => Checkbox(
                                        value: _.allCheck,
                                        onChanged: (value) {
                                          _.allChange(value!);
                                        }),
                                  ),
                                  Text('전체선택'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      for (var item
                                          in cartController.checkList) {
                                        cartController.cartList.removeWhere(
                                            (element) => element.id == item);
                                        // cartController.checkList.remove(item);
                                        print(item);
                                      }

                                      cartController.checkList.clear();
                                    },
                                    child: Text(
                                      '선택삭제',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(
                            height: 50,
                            indent: 0,
                            endIndent: 0,
                            thickness: 2,
                            color: Colors.black,
                          ),

                      Text(
                        '상품정보',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      Divider(
                        height: 50,
                        indent: 0,
                        endIndent: 0,
                        thickness: 2,
                      ),

                      Obx(
                        () => cartController.cartList.isNotEmpty
                            ? ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: cartController.cartList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ProductTile(
                                    //check도.
                                    imageUrl:
                                        cartController.cartList[index].imageURL,
                                    name: cartController.cartList[index].name,
                                    price: cartController.cartList[index].price,
                                    brand:
                                        cartController.cartList[index].company,
                                    id: cartController.cartList[index].id,
                                    //id는 왜 필요하고 index는
                                    index: index,
                                    constraints: constraints,
                                  );
                                },
                              )
                            : Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Icon(
                                      Icons.shopping_cart_outlined,
                                      size: 50,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '장바구니에 상품을 담아보세요.',
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text(
                                        '쇼핑 계속하기',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        padding: EdgeInsets.all(20),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      //1. 체크되고 삭제 되었을 때에?
                      //2. x를 눌렀을 때
                    ],
                  ),
                ),
              ],
            ),
          ),),),
            Footer(),
        ],

      );
    }));
  }
}

class ProductTile extends StatelessWidget {
  ProductTile({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.brand,
    required this.index,
    required this.id,
    required this.constraints
  });

  String imageUrl;
  String name;
  String price;
  String brand;
  String id;
  int index;
  BoxConstraints constraints;
  final CartController cartController = Get.put(CartController());

//여기에 함수를 만들어서 controller에 접근 가능..?
//아 그냥 여기서는 index목록을 추가하고 삭제를 나중에 해도 될 것 같은데???
//여기서 checklist를 추가..

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GetBuilder<CartController>(
            builder: (_) => Checkbox(
                //여기서 ischecked가 cartlist꺼야 해...그럴려면...
                value: _.cartList[index].isChecked,
                onChanged: (value) {
                  _.itemChange(value!, index);
                  if (value == true) {
                    _.checkList.add(id);
                    print(_.checkList);
                  } else {
                    _.checkList.removeWhere((element) => element == id);
                    print(_.checkList);
                  }

                  print(_.cartList[index].isChecked);
                }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              child: Image.network(
            imageUrl,
            width: 100,
            height: 100,
            fit: BoxFit.fill,
          )),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(brand,
    style : TextStyle(
      fontSize: constraints.maxWidth < 1000 ? 8.sp : 18,
                   )),
                RichText(
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  text: TextSpan(
                    text: name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: constraints.maxWidth < 1000 ? 10.sp : 18,
                        color: Colors.black),
                  ),
                ),
                Text(price + '원',
                    style : TextStyle(
                      fontSize: 8.sp,
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
