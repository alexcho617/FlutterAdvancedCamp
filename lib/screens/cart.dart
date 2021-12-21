// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:hemweb/getxController/controller.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var _isChecked = false;

  @override
  Widget build(BuildContext context) {
    // final cartController = Get.put(CartController());
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
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
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
                            onPressed: () {},
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
                  GetBuilder<CartController>(builder: (_) {
                    return Column(
                      children: [
                        Text('Name:${_.cartList[0].name}'),
                        Text('Name:${_.cartList[1].name}')
                      ],
                    );
                    // return ListView.builder(itemBuilder: itemBuilder)
                  }),
                  Divider(
                    height: 50,
                    indent: 0,
                    endIndent: 0,
                    thickness: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
