import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/constants/common_size.dart';

class ProfileBody extends StatefulWidget {

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  bool selectedLeft = true;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // Expanded : Row/Column의 남는 공간을 모두 채워줌
      child: CustomScrollView(
        /** CustomScrollView는 children이 아닌 slivers를 사용하며, slivers에는 스크롤이 가능한 위젯이나 리스트가 등록가능함
         *  사용자정의 스크롤이라 생각하면 될듯. */
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              _username(),
              _userBio(),
              Padding(padding: const EdgeInsets.symmetric(vertical: 6)),
              // or SizedBox(height: 6),
              _editProfileBtn(),
              Row(
                /** mainAxisAlignment 대신 IconButton을 EXpanded로 감싸서 대체가능.*/
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  /**
                      IconButton(
                      icon: ImageIcon(AssetImage('assets/images/grid.png'), // AssetImage : 프로젝트에 등록한 이미지를 사용
                      color: Colors.black87),
                      onPressed: null,
                      ),
                   */
                  IconButton(
                    icon: Icon(
                      Icons.view_comfortable_rounded,
                      color: selectedLeft?Colors.black:Colors.black26,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedLeft = true;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.person_pin_outlined,
                      color: selectedLeft?Colors.black26:Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedLeft = false;
                      });
                    },
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _username() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap),
      child: Text(
        'Jae Min',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _userBio() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap),
      child: Text(
        'Show me the money!!',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
      ),
    );
  }

  Padding _editProfileBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap),
      child: SizedBox(
        height: 24,
        child: OutlineButton(
            onPressed: () {},
            borderSide: BorderSide(color: Colors.black45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text('Edit Profile',
                style: TextStyle(fontWeight: FontWeight.bold))),
      ),
    );
  }
}
