import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/constants/common_size.dart';
import 'package:flutter_instagram/constants/randum_text.dart';
import 'package:flutter_instagram/widgets/comment.dart';
import 'package:flutter_instagram/widgets/my_progress_indicator.dart';
import 'package:flutter_instagram/widgets/rounded_avatar.dart';

class Post extends StatelessWidget {
  final int index; // final은 값이 지정되면 변경할수 없음.
  Size size;

  Post(
    this.index, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (size == null) size = MediaQuery.of(context).size; // device 화면사이즈 가져오기.

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,  ////MainAxisAlignment, CrossAxisAlignment 정렬기능 .start : Column(왼쪽), Row(위쪽) 정렬
      children: <Widget>[
        _postHeader(),
        _postImage(),
        _postActions(),
        _postLikes(),
        _postCaption()
      ],
    );
  }

  Widget _postCaption() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: common_gap, vertical: common_xxs_gap),
      // symmetric 좌우, 위아래 여백설정
      child: Comment(
        showImage: false,
        username: generateRandomString(10),
        text: 'I have money!!'
      ), //Widget/comment.dart
    );
  }

  Padding _postLikes() {
    return Padding(
      padding: const EdgeInsets.only(left: common_gap),
      // only(left) 왼쪽만 padding
      child: Text(
        '12000 likes',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Row _postActions() {
    return Row(
      children: <Widget>[
        IconButton(
          onPressed: null,
          icon: ImageIcon(AssetImage('assets/images/heart_selected.png')), color: Colors.black54, iconSize: 20,
          //icon: Icon(Icons.bookmark_outline_outlined, color: Colors.black54),
        ),
        IconButton(
          onPressed: null,
          icon: ImageIcon(AssetImage('assets/images/comment.png')), color: Colors.black54, iconSize: 20,
          //icon: Icon(Icons.mode_comment_outlined, color: Colors.black54),
        ),
        IconButton(
          onPressed: null,
          icon: ImageIcon(AssetImage('assets/images/direct_message.png')),  color: Colors.black54, iconSize: 20,
          //icon: Icon(Icons.sms_outlined, color: Colors.black54),
        ),
        Spacer(), // Widget 사이에 공간을 만들어줌.
        IconButton(
          onPressed: null,
          icon: ImageIcon(AssetImage('assets/images/bookmark.png')), color: Colors.black54, iconSize: 20,
          //icon: Icon(Icons.favorite_border_rounded, color: Colors.black54),
        ),
      ],
    );
  }

  Widget _postHeader() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(common_xxs_gap),
          child: RoundedAvatar(), // widgets/rounded_avatar.dart
        ),
        Expanded(child: Text('Jae Min')),
        // Expanded : Row/Column의 남는 공간을 모두 채워줌
        IconButton(
          onPressed: null,
          icon: Icon(
            Icons.more_horiz,
            color: Colors.black87,
          ),
        )
      ],
    );
  }

  CachedNetworkImage _postImage() {
    return CachedNetworkImage(
      // CachedNetworkImage : 이미지는 page 이동마다 image 를 다시 다운받음 CachedNetworkImage는 메모리에 올려두고 재사용
      imageUrl: 'https://picsum.photos/id/$index/200/200',
      placeholder: (BuildContext context, String url) {
        return MyProgressIndicator(
            containerSize:
                size.width); // Progress생성 Widgets/my_progress_indicator.dart
      },
      imageBuilder: (BuildContext context, ImageProvider imageProvider) {
        // imageProvider : imageUrl로 받아온 이미지 정보가 담김.
        return AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: imageProvider, fit: BoxFit.cover)),
          ),
        );
      },
    );
  }
}
