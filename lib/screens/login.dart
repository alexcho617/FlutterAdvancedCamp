// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hemweb/getxController/authController.dart';

import '/screens/home.dart';

class LoginPage extends StatelessWidget {
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: '아이디 입력'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  width: 566,
                  height: 50,
                  child: TextField(
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
                    child: TextButton(onPressed: () {}, child: Text("로그인",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),))),
              ),
              Padding(padding: const EdgeInsets.only(top: 15.0),
              child: SizedBox(
                height: 40.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextButton(onPressed: (){}, child: Text("아이디 찾기", style: Theme.of(context).textTheme.button,)),
                    ),
                    SizedBox(height: 14,child: const VerticalDivider()),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextButton(onPressed: (){}, child: Text("비밀번호 찾기", style: Theme.of(context).textTheme.button,)),
                    ),
                    SizedBox(height: 14,child: const VerticalDivider()),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextButton(onPressed: (){}, child: Text("회원가입", style: Theme.of(context).textTheme.button,)),
                    ),
                  ],
                ),
              ),),
              SizedBox(
                height: 100.0,
              ),
              Row(
                children: const <Widget>[
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.fromLTRB(6,0,6,0),
                    child: Text("SNS 로그인/가입"),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              SizedBox(height: 20,),
              Center(
                child: InkWell(
                  onTap: (){
                    authController.signInWithGoogle();
                  },
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: Image.asset('assets/googleLoginIcon.png').image
                      )
                    ),
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
