import 'package:flutter/material.dart';
import 'package:flutter_instagram/constants/material_white.dart';
//import 'package:flutter_instagram/home_page.dart';
import 'package:flutter_instagram/screens/auth_screen.dart';

void main() {
  runApp(MyApp());
}
//StatelessWidget : 위젯의 상태변화가 없으면
//StatefulWidget : 위젯의 상태변화가 있으면

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      home: HomePage(), // Refactor - flutter widget
      home: AuthScreen(), // Refactor - flutter widget
      theme: ThemeData(primarySwatch: white), //전체적인 Theme을 생성 모든 화면에 적용
    );
  }
}


