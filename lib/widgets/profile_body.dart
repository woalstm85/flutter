import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/constants/common_size.dart';
import 'package:flutter_instagram/constants/screen_size.dart';
import 'package:flutter_instagram/screens/profile_screen.dart';
import 'package:flutter_instagram/widgets/rounded_avatar.dart';

class ProfileBody extends StatefulWidget {

  final Function onMenuChanged;

  const ProfileBody({Key key, this.onMenuChanged}) : super(key: key);

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  //bool selectedLeft = true;
  SelectedTab _selectedTab = SelectedTab.left;
  double _leftImageMarginX = 0;
  double _rightImageMarginX = size.width;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _appBar(),
          Expanded(
            // Expanded : Row/Column의 남는 공간을 모두 채워줌
            child: CustomScrollView(
              /** CustomScrollView는 children이 아닌 slivers를 사용하며, slivers에는 스크롤이 가능한 위젯이나 리스트가 등록가능함
               *  사용자정의 스크롤이라 생각하면 될듯. */
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate([
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(common_gap),
                          child: RoundedAvatar(
                            size: 80,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: common_gap),
                            child: Table(
                              children: [
                                TableRow(children: [
                                  _valueText('7,584'),
                                  _valueText('1,492'),
                                  _valueText('792'),
                                ]),
                                TableRow(children: [
                                  _labelText('Post'),
                                  _labelText('Followers'),
                                  _labelText('Following'),
                                ])
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    _username(),
                    _userBio(),
                    Padding(padding: const EdgeInsets.symmetric(vertical: 6)),
                    // or SizedBox(height: 6),
                    _editProfileBtn(),
                    _tabButtons(),
                    _selectedIndicator(),
                  ]),
                ),
                _imagesPager()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _appBar() {
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
          onPressed: () {
            widget.onMenuChanged();
          },
        )
      ],
    );
  }

  Text _valueText(String value) {
    return Text(value,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold));
  }

  Text _labelText(String label) {
    return Text(label,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 11));
  }

  SliverToBoxAdapter _imagesPager() {
    return SliverToBoxAdapter(
        child: Stack(
      children: <Widget>[
        AnimatedContainer(
          duration: duration,
          transform: Matrix4.translationValues(_leftImageMarginX, 0, 0),
          curve: Curves.fastOutSlowIn,
          child: _images(),
        ),
        AnimatedContainer(
          duration: duration,
          transform: Matrix4.translationValues(_rightImageMarginX, 0, 0),
          curve: Curves.fastOutSlowIn,
          child: _images(),
        )
      ],
    ));
  }

  GridView _images() {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      // GridView 에서는 스크롤 제스쳐를 무시
      shrinkWrap: true,
      crossAxisCount: 3,
      // crossAxisCount: 칸 수
      childAspectRatio: 1,
      // childAspectRatio : 비율
      children: List.generate(
          84,
          (index) => CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: "https://picsum.photos/id/$index/100/100",
              )),
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
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.black45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: Text('Edit Profile',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
          onPressed: () {},
        ),
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
              _tabSelected(SelectedTab.left);
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
              _tabSelected(SelectedTab.right);
            });
          },
        ),
      ],
    );
  }

  _tabSelected(SelectedTab selectedTab) {
    setState(() {
      switch (selectedTab) {
        case SelectedTab.left:
          _selectedTab = SelectedTab.left;
          _leftImageMarginX = 0;
          _rightImageMarginX = size.width;
          break;
        case SelectedTab.right:
          _selectedTab = SelectedTab.right;
          _leftImageMarginX = -size.width;
          _rightImageMarginX = 0;
          break;
      }
    });
  }

  Widget _selectedIndicator() {
    return AnimatedContainer(
      duration: duration,
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

//enum은 클래스 안에서 정의할 수 없고 class 밖에서 정의
enum SelectedTab { left, right } // 안에는 타입들을 정의
