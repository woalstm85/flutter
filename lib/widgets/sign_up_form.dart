import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_instagram/constants/auth_input_decor.dart';
import 'package:flutter_instagram/constants/common_size.dart';
import 'package:flutter_instagram/models/firebase_auth_state.dart';
import 'package:flutter_instagram/widgets/or_divider.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _emailController =
      TextEditingController(); // TextFormField 를 사용시 필수
  TextEditingController _pwController =
      TextEditingController(); // TextFormField 를 사용시 필수
  TextEditingController _cpwController =
      TextEditingController(); // TextFormField 를 사용시 필수

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    _cpwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(common_gap),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: common_l_gap,
              ),
              Image.asset('assets/images/insta_text_logo.png'),
              TextFormField(
                controller: _emailController,
                cursorColor: Colors.black54,
                decoration: textInputDecoration('Email'),
                validator: (text) {
                  if (text.isNotEmpty && text.contains("@")) {
                    return null;
                  } else {
                    return '정확한 이메일 주소를 입력해주세요.';
                  }
                },
              ),
              SizedBox(
                height: common_xs_gap,
              ),
              TextFormField(
                controller: _pwController,
                cursorColor: Colors.black54,
                obscureText: true,
                decoration: textInputDecoration('Password'),
                validator: (text) {
                  if (text.isNotEmpty && text.length > 1) {
                    return null;
                  } else {
                    return '비밀번호는 1자리이상 입력해주세요.';
                  }
                },
              ),
              SizedBox(
                height: common_xs_gap,
              ),
              TextFormField(
                controller: _cpwController,
                cursorColor: Colors.black54,
                obscureText: true,
                decoration: textInputDecoration('Confirm Password'),
                validator: (text) {
                  if (text.isNotEmpty && _pwController.text == text) {
                    return null;
                  } else {
                    return '입력한 비밀번호와 일치하지 않습니다.';
                  }
                },
              ),
              SizedBox(
                height: common_s_gap,
              ),
              _submitButton(context),
              SizedBox(
                height: common_s_gap,
              ),
              OrDivider(),
              TextButton.icon(
                onPressed: () {
                  Provider.of<FirebaseAuthState>(context, listen: false)
                      .loginWithFacebook(context);
                },
                style: TextButton.styleFrom(primary: Colors.blue),
                icon: ImageIcon(
                  AssetImage('assets/images/facebook.png'),
                ),
                label: Text(
                  'Login with Facebook',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextButton _submitButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        // _formKey.currentState.validate : Form에 있는 validator들을 실행.
        if (_formKey.currentState.validate()) {
          print('Validation success!!');
          /**
           * pushReplacement : 페이지 이동 시 현재 페이지를 없애고 다른 페이지로 이동. route 페이지가 변경.
           * 예 ) 첫화면이 로그인 페이지에서 로그인 후 메인페이지로 이동하면 메인페이지가 route 페이지가 된다.
           * push : 로그인 후  메인페이지가 로그인페이지위로 보이는 것.
           */

          Provider.of<FirebaseAuthState>(context, listen: false)
              .registerUser(context, email: _emailController.text, password: _pwController.text);
        }
      },
      child: Text('Join'),
      style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.blue,
          onSurface: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          )),
    );
  }
}
