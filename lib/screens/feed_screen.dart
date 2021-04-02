import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/widgets/post.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        leading: IconButton(
            onPressed: null,
            icon: Icon(
              CupertinoIcons.photo_camera_solid, // or Icons.camera_alt,
              color: Colors.black87,
            )),
        middle: Text(
          'instagram',
          style: TextStyle(fontFamily: 'VeganStyle'),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              onPressed: null,
              icon: ImageIcon(
                AssetImage('assets/images/actionbar_camera.png'),
                color: Colors.black87,
              ),
            ),
            /** 계속 추가할수 있음
            IconButton(
              onPressed: null,
              icon: ImageIcon(
                AssetImage('assets/images/actionbar_camera.png'),
                color: Colors.black87,
              ),
            ),
            **/
          ],
        ),
      ),
      body: ListView.builder(
        itemBuilder: feedListBuilder,
        itemCount: 16, // ListView 생성 , itemCount : 갯수
      ),
    );
  }

  // feedListBuilder( index를 받아와서 ListView 생성)
  Widget feedListBuilder(BuildContext context, int index) {
    return Post(index);
  }
}

