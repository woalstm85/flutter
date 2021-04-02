import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_instagram/widgets/profile_body.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        // device 상단(시간, 배터리 등등) 표시영역을 넘어가지안도록
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _appbar(),
            ProfileBody(),
          ],
        ),
      ),
    );
  }

  Row _appbar() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 44,
        ),
        Expanded(
            child: Text(
              'Zzams',
              textAlign: TextAlign.center,
            )),
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        )
      ],
    );
  }

}
