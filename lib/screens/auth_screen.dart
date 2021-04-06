import 'package:flutter/material.dart';
import 'package:flutter_instagram/screens/profile_screen.dart';
import 'package:flutter_instagram/widgets/fade_stack.dart';
import 'package:flutter_instagram/widgets/sign_in_form.dart';
import 'package:flutter_instagram/widgets/sign_up_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int selectedForm = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            FadeStack(
              selectedForm: selectedForm,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 40,
              child: Container(
                color: Colors.white,
                child: FlatButton(
                  shape: Border(
                    top: BorderSide(color: Colors.grey[300])
                  ),
                  child: RichText(
                      text: TextSpan(
                          text: (selectedForm == 1)
                              ? 'Already have an account?'
                              : "Don't have an account?",
                          style: TextStyle(color: Colors.grey),
                          children: [
                        TextSpan(
                            text: (selectedForm == 0)
                                ? " Sign In"
                                : " Sign Up",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold)),
                      ])),
                  onPressed: () {
                    setState(() {
                      if (selectedForm == 0) {
                        selectedForm = 1;
                      } else {
                        selectedForm = 0;
                      }
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
