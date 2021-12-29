import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hemweb/app/routes/app_pages.dart';

import '../../../../services/auth_service.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
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
                      border: OutlineInputBorder(), labelText: '이메일 입력'),
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
                        border: OutlineInputBorder(), labelText: '비밀번호 입력'),
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
                          //Implement Email Login here
                          AuthService.to.login(
                              _emailController.text, _passwordController.text);
                        },
                        child: Text(
                          "로그인",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
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
                              style: Theme.of(context).textTheme.button,
                            )),
                      ),
                      SizedBox(height: 14, child: const VerticalDivider()),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextButton(
                            onPressed: () {},
                            onLongPress: () {
                              //Implement Admin Login here
                            },
                            child: Text(
                              "비밀번호 찾기",
                              style: Theme.of(context).textTheme.button,
                            )),
                      ),
                      SizedBox(height: 14, child: const VerticalDivider()),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextButton(
                            onPressed: () {
                              //Implement Register with Email here
                            },
                            child: Text(
                              "회원가입",
                              style: Theme.of(context).textTheme.button,
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
                    //Implement Google Sign in here
                  },
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: Image.asset('assets/googleLoginIcon.png')
                                .image)),
                  ),
                ),
              ),
              // Image.asset('assets/googleLoginIcon.jpg'),
            ],
          ),
        ),
      ),
    );
  }
}
