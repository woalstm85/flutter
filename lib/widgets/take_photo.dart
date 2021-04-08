import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/constants/common_size.dart';
import 'package:flutter_instagram/constants/screen_size.dart';

class TakePhoto extends StatelessWidget {
  const TakePhoto({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: size.width,
          height: size.width *1.4,
          color: Colors.black,
        ),
        Expanded(
          child: OutlinedButton(
            onPressed: (){},
            style: OutlinedButton.styleFrom(
              minimumSize: Size.square(100.0),
              shape: CircleBorder(),
              side: BorderSide(color: Colors.black12, width: 20),
            ),
          ),
        ),
      ],
    );
  }
}

/**
 * InkWell(
    onTap: () {},
    child: Padding(
    padding: const EdgeInsets.all(common_s_gap),
    child: Container(
    decoration: ShapeDecoration(
    shape: CircleBorder(
    side: BorderSide(
    color: Colors.black12,
    width: 20,
    ))),
    ),
    ),
    )
 */
