// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/screens/home.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 70.0,
            ),
            Text(
              "안녕하세요 :)\n하이버입니다",
              style: TextStyle(fontSize: 29.0),
            ), //text-align: center; padding-top: 20px color:#000000; font-size: 14px; padding-left: 30px
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
                  width: 556,
                  height: 50,
                  color: Colors.black,
                  child: TextButton(onPressed: () {}, child: Text("로그인",style: TextStyle(color: Colors.white),))),
            ),
          ],
        ),
      ),
    );
  }
}

// '''
// TextTheme _textTheme(TextTheme base){
//   return base
//       .copyWith(
//       bodyText2: base.headline1!.copyWith(
//         fontSize: 29.0,
//       )
//   );
// }
//
// ThemeData _themeData(){
//   final ThemeData base = ThemeData.light();
//   return ThemeData(
//     textTheme: _textTheme(base.textTheme),
//   );
// }
// '''
