import 'package:flutter/material.dart';

class ProfileSideMenu extends StatelessWidget {
  final double menuWidth;

  // ignore: slash_for_doc_comments
  /**
   * {Key key, this.menuWidth} ->{} 안에 this.menuWidth 있으면 option 값( 값이  있어도 되고 없어도 되고)
   * this.menuWidth, {Key key,} -> {} 밖에 this.menuWidth 있으면 필수 값.
   **/
  const ProfileSideMenu(
    this.menuWidth, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        // SizeBox : child를 사이즈를 정의.
        width: menuWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              title: Text(
                'Setting',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.black87),
              title: Text('Sign out'),
            )
          ],
        ),
      ),
    );
  }
}
