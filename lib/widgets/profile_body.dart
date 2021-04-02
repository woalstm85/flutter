import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/constants/common_size.dart';
import 'package:flutter_instagram/constants/screen_size.dart';

class ProfileBody extends StatefulWidget {
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  //bool selectedLeft = true;
  SelectedTab _selectedTab = SelectedTab.left;

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
              _tabButtons(),
              _selectedIndicator(),
            ]),
          ),
          SliverToBoxAdapter(
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(), // GridView 에서는 스크롤 제스쳐를 무시
              shrinkWrap: true,
              crossAxisCount: 3, // crossAxisCount: 칸 수
              childAspectRatio: 1, // childAspectRatio : 비율
              children: List.generate(
                84,
                (index) => CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: "https://picsum.photos/id/$index/100/100",
                ),
              ),
            ),
          )
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

  Row _tabButtons() {
    return Row(
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
            color: _selectedTab == SelectedTab.left
                ? Colors.black
                : Colors.black26,
          ),
          onPressed: () {
            setState(() {
              _selectedTab = SelectedTab.left;
            });
          },
        ),
        IconButton(
          icon: Icon(
            Icons.person_pin_outlined,
            color: _selectedTab == SelectedTab.left
                ? Colors.black26
                : Colors.black,
          ),
          onPressed: () {
            setState(() {
              _selectedTab = SelectedTab.right;
            });
          },
        ),
      ],
    );
  }

  Widget _selectedIndicator() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      alignment: _selectedTab == SelectedTab.left
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Container(
        height: 3,
        width: size.width / 2,
        color: Colors.black87,
      ),
      curve: Curves.fastOutSlowIn,
    );
  }
}

/** enum은 클래스 안에서 정의할 수 없고 class 밖에서 정의 */
enum SelectedTab { left, right } // 안에는 타입들을 정의
