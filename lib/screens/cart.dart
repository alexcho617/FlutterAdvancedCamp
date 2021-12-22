// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hemweb/screens/home.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:hemweb/getxController/authController.dart';
import 'package:hemweb/getxController/cartController.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var _isChecked = false;

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: ListView(
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
                              Checkbox(
                                  value: _isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      _isChecked = value!;
                                    });
                                    print(_isChecked);
                                  }),
                              Text('전체선택'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  for (var item in cartController.checkList) {
                                    cartController.cartList.removeWhere((
                                        element) => element.id == item);
                                    print(item);
                                  }
                                },
                                child: Text(
                                  '선택삭제',
                                  style: TextStyle(color: Colors.black),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  '품절삭제',
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

                      Obx(() =>
                          cartController.cartList.isNotEmpty ?
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cartController.cartList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ProductTile(
                            imageUrl: cartController.cartList[index]
                                .imageURL,
                            name: cartController.cartList[index].name,
                            price: cartController.cartList[index].price,
                            brand: cartController.cartList[index]
                                .company,
                            index: cartController.cartList[index].id,);
                        },
                      )
                          :
                      Center(
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
                                Get.to(HomePage());
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
          )),
    );
  }
}

class ProductTile extends StatefulWidget {

  ProductTile(
      {required this.imageUrl, required this.name, required this.price, required this.brand, required this.index});

  String imageUrl;
  String name;
  String price;
  String brand;
  String index;

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  final CartController cartController = Get.put(CartController());
  var _isChecked = false;

  //여기에 함수를 만들어서 controller에 접근 가능..?
  //아 그냥 여기서는 index목록을 추가하고 삭제를 나중에 해도 될 것 같은데???

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Checkbox(
                  value: _isChecked,
                  onChanged: (value) {
                    setState(() {
                      _isChecked = value!;
                      if (value == true) {
                        cartController.checkList.add(widget.index);
                        print(cartController.checkList);
                      }
                      else {
                        cartController.checkList.removeWhere((
                            element) => element == widget.index);
                        print(cartController.checkList);
                      }
                    });
                    print(_isChecked);
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(child: Image.network(
                widget.imageUrl, width: 100, height: 100, fit: BoxFit.fill,)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.brand),
                  Text(widget.name + "\n" + widget.price + '원',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),),
                ],
              ),
            ),

          ],
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.cancel)),
      ],
    );
  }
}
