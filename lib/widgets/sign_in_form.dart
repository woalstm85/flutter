import 'package:flutter/material.dart';
import 'package:flutter_instagram/constants/auth_input_decor.dart';
import 'package:flutter_instagram/constants/common_size.dart';
import 'package:flutter_instagram/widgets/or_divider.dart';
import 'package:flutter_instagram/widgets/sign_up_form.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _emailController =
      TextEditingController(); // TextFormField 를 사용시 필수
  TextEditingController _pwController =
      TextEditingController(); // TextFormField 를 사용시 필수

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(common_gap),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(
              height: common_l_gap,
            ),
            Image.asset('assets/images/insta_text_logo.png'),
            TextFormField(
              controller: _emailController,
              cursorColor: Colors.black87,
              decoration: textInputDecoration('Email'),
              validator: (text) {
                if (text.isNotEmpty && text.contains('@')) {
                  return null;
                } else {
                  return '정확한 이메일 주소를 입력해주세요.';
                }
              },
            ),
            SizedBox(
              height: common_s_gap,
            ),
            TextFormField(
              controller: _pwController,
              cursorColor: Colors.black87,
              obscureText: true,
              decoration: textInputDecoration('Password'),
              validator: (text) {
                if (text.isNotEmpty && text.length > 1) {
                  return null;
                } else {
                  return '비밀번호는 1자리 이상 입력하세요.';
                }
              },
            ),
            TextButton(
                onPressed: () {},
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgotten password?',
                    style: TextStyle(color: Colors.blue),
                  ),
                )),
            _submitButton(context),
            SizedBox(
              height: common_xs_gap,
            ),
            OrDivider(),
            TextButton.icon(
              onPressed: () {},
              style: TextButton.styleFrom(primary: Colors.blue),
              icon: ImageIcon(
                AssetImage('assets/images/facebook.png'),
              ),
              label: Text('Login with Facebook'),
            ),
          ],
        ),
      ),
    );
  }

  TextButton _submitButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          print('Validation success!!');
          /**
           * pushReplacement : 페이지 이동 시 현재 페이지를 없애고 다른 페이지로 이동. route 페이지가 변경.
           * 예 ) 첫화면이 로그인 페이지에서 로그인 후 메인페이지로 이동하면 메인페이지가 route 페이지가 된다.
           * push : 로그인 후  메인페이지가 로그인페이지위로 보이는 것.
           */
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => SignUpForm()));
        }
      },
      child: Text('Log in'),
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
