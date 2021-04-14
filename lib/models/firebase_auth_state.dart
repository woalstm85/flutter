import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_instagram/repo/user_network_repository.dart';
import 'package:flutter_instagram/utils/simple_snackbar.dart';

class FirebaseAuthState extends ChangeNotifier {
  FirebaseAuthStatus _firebaseAuthStatus = FirebaseAuthStatus.progress;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser _firebaseUser;
  FacebookLogin _facebookLogin;

  void watchAuthStatus() {
    _firebaseAuth.onAuthStateChanged.listen((firebaseUser) {
      if (firebaseUser == null && _firebaseUser == null) {
        changeFirebaseAuthStatus();
        return;
      } else if (firebaseUser != _firebaseUser) {
        _firebaseUser = firebaseUser;
        changeFirebaseAuthStatus();
      }
    });
  }

  void registerUser(BuildContext context,
      {@required String email, @required String password}) async {
    changeFirebaseAuthStatus(FirebaseAuthStatus.progress);
    AuthResult authResult = await _firebaseAuth
        .createUserWithEmailAndPassword(
            email: email.trim(), password: password.trim())
        .catchError((error) {
      print(error);
      String _message = "";
      switch (error.code) {
        case 'ERROR_WEAK_PASSWORD':
          _message = "비밀번호는 6자리 이상 입력해주세요.";
          break;
        case 'ERROR_INVALID_EMAIL':
          _message = "유효하지 않은 이메일주소입니다.";
          break;
        case 'ERROR_EMAIL_ALREADY_IN_USE':
          _message = "해당 이메일은 사용중입니다.";
          break;
        /**
          case 'email-already-in-use':
          _message = "해당 이메일은 사용중입니다.";
          break;
          case 'invalid-email':
          _message = "유요하지 않은 이메일주소입니다.";
          break;
          case 'operation-not-allowed':
          _message = "해당 이메일은 비활성상태입니다.";
          break;
          case 'weak-password':
          _message = "비밀번호는 6자리 이상 입력해주세요.";
          break;
       */
      }

      SnackBar snackBar = SnackBar(
        content: Text(_message),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

    _firebaseUser = authResult.user;
    if (_firebaseUser == null) {
      SnackBar snackBar = SnackBar(
        content: Text('다시 시도해 주세요.!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      await userNetworkRepository.attemptCreateUser(
          userKey: _firebaseUser.uid, email: _firebaseUser.email);
    }
  }

  void login(BuildContext context,
      {@required String email, @required String password}) async {
    changeFirebaseAuthStatus(FirebaseAuthStatus.progress);
    AuthResult authResult = await _firebaseAuth
        .signInWithEmailAndPassword(
            email: email.trim(), password: password.trim())
        .catchError((error) {
      print(error);
      String _message = "";
      switch (error.code) {
        case 'ERROR_INVALID_EMAIL':
          _message = "유효하지 않은 이메일입니다.";
          break;
        case 'ERROR_WRONG_PASSWORD':
          _message = "잘못된 비밀번호입니다.";
          break;
        case 'ERROR_USER_NOT_FOUND':
          _message = "유저가 존재하지 않습니다.";
          break;
        case 'ERROR_USER_DISABLED':
          _message = "사용중지된 사용자입니다.";
          break;
        case 'ERROR_TOO_MANY_REQUESTS':
          _message = "유효하지 않은 이메일입니다.";
          break;
        case 'ERROR_OPERATION_NOT_ALLOWED':
          _message = "이메일 및 계정이 비활성화 상태입니다.";
          break;

        /**
          case 'user-disabled':
          _message = "해당 이메일은 비활성상태입니다.";
          break;
          case 'invalid-email':
          _message = "유요하지 않은 이메일주소입니다.";
          break;
          case 'user-not-found':
          _message = "유저가 존재하지 않습니다.";
          break;
          case 'wrong-password':
          _message = "잘못된 비밀번호입니다..";
          break;
       */
      }

      SnackBar snackBar = SnackBar(
        content: Text(_message),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

    _firebaseUser = authResult.user;
    if (_firebaseUser == null) {
      SnackBar snackBar = SnackBar(
        content: Text('다시 시도해 주세요.!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      await userNetworkRepository.attemptCreateUser(
          userKey: _firebaseUser.uid, email: _firebaseUser.email);
    }
  }

  void signOut() async {
    changeFirebaseAuthStatus(FirebaseAuthStatus.progress);

    _firebaseAuthStatus = FirebaseAuthStatus.signout;
    if (_firebaseUser != null) {
      _firebaseUser = null;
      await _firebaseAuth.signOut();
      if (await _facebookLogin.isLoggedIn) {
        await _facebookLogin.logOut();
      }
    }
    notifyListeners();
  }

  void changeFirebaseAuthStatus([FirebaseAuthStatus firebaseAuthStatus]) {
    if (firebaseAuthStatus != null) {
      _firebaseAuthStatus = firebaseAuthStatus;
    } else {
      if (_firebaseUser != null) {
        _firebaseAuthStatus = FirebaseAuthStatus.signin;
      } else {
        _firebaseAuthStatus = FirebaseAuthStatus.signout;
      }
    }
    notifyListeners();
  }

  void loginWithFacebook(BuildContext context) async {
    changeFirebaseAuthStatus(FirebaseAuthStatus.progress);

    if (_facebookLogin == null) _facebookLogin = FacebookLogin();
    final result = await _facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        _handleFacebookTokenWithFirebase(
            context, result.accessToken.token); // 페이스북 로그인요청시 token을 가져옴.
        break;
      case FacebookLoginStatus.cancelledByUser:
        simpleSnackbar(context, 'Facebook 로그인 취소.');
        break;
      case FacebookLoginStatus.error:
        simpleSnackbar(context, 'Facebook 로그인 중 오류.');
        break;
    }
  }

  void _handleFacebookTokenWithFirebase(
      BuildContext context, String token) async {
    final AuthCredential credential =
        FacebookAuthProvider.getCredential(accessToken: token);

    final AuthResult userCredential =
        await _firebaseAuth.signInWithCredential(credential);
    final FirebaseUser user = userCredential.user;

    if (user == null) {
      simpleSnackbar(context, '페북 로그인이 지연되고있어요. 나중에 다시 해보세요.');
    } else {
      _firebaseUser = user;
    }
    notifyListeners();
  }

  FirebaseAuthStatus get firebaseAuthStatus => _firebaseAuthStatus;

  FirebaseUser get firebaseUser => _firebaseUser;
}

enum FirebaseAuthStatus { signout, progress, signin }
