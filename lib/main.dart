import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/constants/material_white.dart';
import 'package:flutter_instagram/home_page.dart';
import 'package:flutter_instagram/models/firebase_auth_state.dart';
import 'package:flutter_instagram/models/firestore/user_model.dart';
import 'package:flutter_instagram/models/user_model_state.dart';
import 'package:flutter_instagram/repo/user_network_repository.dart';
import 'package:flutter_instagram/screens/auth_screen.dart';
import 'package:flutter_instagram/widgets/my_progress_indicator.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}
//StatelessWidget : 위젯의 상태변화가 없으면
//StatefulWidget : 위젯의 상태변화가 있으면

class MyApp extends StatelessWidget {
  FirebaseAuthState _firebaseAuthState = FirebaseAuthState();
  Widget _currentWidget;

  @override
  Widget build(BuildContext context) {
    _firebaseAuthState.watchAuthStatus();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseAuthState>.value(
            value: _firebaseAuthState),
        ChangeNotifierProvider<UserModelState>(
          create: (_) => UserModelState(),
        ),
      ],
      child: MaterialApp(
        home: Consumer<FirebaseAuthState>(builder: (BuildContext context,
            FirebaseAuthState firebaseAuthState, Widget child) {
          switch (firebaseAuthState.firebaseAuthStatus) {
            case FirebaseAuthStatus.signout:
              _clearUserModel(context);
              _currentWidget = AuthScreen();
              break;
            case FirebaseAuthStatus.signin:
              _initUserModel(firebaseAuthState, context);
              _currentWidget = HomePage();
              break;
            default:
              _currentWidget = MyProgressIndicator();
          }

          return AnimatedSwitcher(
            duration: Duration(milliseconds: 1000),
            child: _currentWidget,
          );
        }), // Refactor - flutter widget
//        home: AuthScreen(), // Refactor - flutter widget
        theme: ThemeData(primarySwatch: white), //전체적인 Theme을 생성 모든 화면에 적용
      ),
    );
  }

  void _initUserModel(
      FirebaseAuthState firebaseAuthState, BuildContext context) {
    UserModelState userModelState =
        Provider.of<UserModelState>(context, listen: false);
    userModelState.currentStreamSub = userNetworkRepository
        .getUserModelStream(firebaseAuthState.firebaseUser.uid)
        .listen((userModel) {
      userModelState.userModel = userModel;
    });
  }

  void _clearUserModel(BuildContext context) {
    UserModelState userModelState =
        Provider.of<UserModelState>(context, listen: false);
    userModelState.clear();
  }
}
