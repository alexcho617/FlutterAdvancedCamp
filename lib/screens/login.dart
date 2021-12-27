// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hemweb/getxController/authController.dart';
import 'package:hemweb/widgets/footer.dart';

import '/screens/cart.dart';
import '/screens/my.dart';
import '/screens/home.dart';

class LoginPage extends StatelessWidget {
  final authController = Get.find<AuthController>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
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
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.search)),
                          IconButton(
                              onPressed: () {
                                if (authController.loginState ==
                                    LoginState.loggedOut) {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('로그인'),
                                      content: const Text(
                                          '장바구니에 상품을 담으려면 로그인을 하셔야 합니다.'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => Get.back(),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                if (authController.loginState ==
                                    LoginState.loggedIn) Get.to(CartPage());
                              },
                              icon: Icon(Icons.shopping_cart_outlined)),
                          IconButton(
                              onPressed: () {
                                // //var authController = Get.find<AuthController>();
                                print(authController.loginState);
                                // if(authController.loginState == LoginState.loggedOut) Get.to(LoginPage());
                                // if(authController.loginState == LoginState.loggedIn) Get.to(MyPage());
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
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    width: 566,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 70.0,
                        ),
                        Text(
                          "안녕하세요 :)\n하이버입니다.",
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Text("브랜디/하이버/마미의 통합회원으로 로그인 가능합니다."),
                        const SizedBox(
                          height: 50.0,
                        ),
                        SizedBox(
                          width: 566,
                          height: 50,
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: '이메일 입력'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: SizedBox(
                            width: 566,
                            height: 50,
                            child: TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: '비밀번호 입력'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Container(
                              width: 566,
                              height: 50,
                              color: Colors.black,
                              child: TextButton(
                                  onPressed: () {
                                    authController.login(_emailController.text,
                                        _passwordController.text);
                                  },
                                  child: Text(
                                    "로그인",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: SizedBox(
                            height: 40.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        "아이디 찾기",
                                        style:
                                            Theme.of(context).textTheme.button,
                                      )),
                                ),
                                SizedBox(
                                    height: 14, child: const VerticalDivider()),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextButton(
                                      onPressed: () {},
                                      onLongPress: () {
                                        authController.login(
                                            "admin@admin.com", "123456");
                                      },
                                      child: Text(
                                        "비밀번호 찾기",
                                        style:
                                            Theme.of(context).textTheme.button,
                                      )),
                                ),
                                SizedBox(
                                    height: 14, child: const VerticalDivider()),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextButton(
                                      onPressed: () {
                                        authController.register(
                                            _emailController.text,
                                            _passwordController.text);
                                      },
                                      child: Text(
                                        "회원가입",
                                        style:
                                            Theme.of(context).textTheme.button,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100.0,
                        ),
                        Row(
                          children: const <Widget>[
                            Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                              child: Text("SNS 로그인/가입"),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              authController.signInWithGoogle();
                            },
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: Image.asset(
                                              'assets/googleLoginIcon.png')
                                          .image)),
                            ),
                          ),
                        ),
                        // Image.asset('assets/googleLoginIcon.jpg'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Footer()
          ],
        );
      }),
    );
  }
}
