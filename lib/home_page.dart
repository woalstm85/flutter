import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/constants/screen_size.dart';
import 'package:flutter_instagram/screens/camera_screen.dart';
import 'package:flutter_instagram/screens/feed_screen.dart';
import 'package:flutter_instagram/screens/profile_screen.dart';
import 'package:flutter_instagram/screens/search_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  List<BottomNavigationBarItem> btmNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
    BottomNavigationBarItem(
        icon: Icon(Icons.image_search_outlined), label: 'search'),
    BottomNavigationBarItem(
        icon: Icon(Icons.add_a_photo_outlined), label: 'camera'),
    BottomNavigationBarItem(
        icon: Icon(Icons.shopping_bag_outlined), label: 'shop'),
    BottomNavigationBarItem(
        icon: Icon(Icons.account_circle_outlined), label: 'profile'),
  ];

  int _selectedIndex = 0;
  GlobalKey<ScaffoldMessengerState> _key = GlobalKey<ScaffoldMessengerState>();

  static List<Widget> _screens = <Widget>[
    FeedScreen(),
    SearchScreen(),
    Container(
      color: Colors.deepOrangeAccent,
    ),
    Container(
      color: Colors.blueAccent,
    ),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    if (size == null) size = MediaQuery.of(context).size; // device 화면사이즈 가져오기.
    return ScaffoldMessenger(
      key: _key,
      child: Scaffold(
        body: IndexedStack(
          // 페이지를 re-build가 아닌 쌓는형식
          index: _selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: btmNavItems,
          showUnselectedLabels: false,
          // 선택 안된 아이템의 text 표시 여부
          showSelectedLabels: true,
          // 선택된 아이템의 text 표시 여부
          selectedFontSize: 12,
          //선택된 아이템의 폰트사이즈
          //unselectedFontSize: 14, //선택 안된 아이템의 폰트사이즈
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey,
          // //선택 안된 아이템의 색상
          selectedItemColor: Colors.black87,
          //선택된 아이템의 색상
          currentIndex: _selectedIndex,
          // //현재 선택된 Index
          onTap: _onBtmItemClick, // 아이템 선택 시 _onBtmItemClick function 실행
        ),
      ),
    );
  }

  void _onBtmItemClick(int index) {
    switch (index) {
      case 2:
        _openCamera();
        break;
      default:
        {
          setState(() {
            _selectedIndex = index;
          });
        }
    }
  }

  void _openCamera() async {
    /**
     * Navigator :  페이지 이동을 위한 class
     * push : Stack으로 페이지위에 카메라 페이지를 띄운거라 <- (back) 버튼이 자동으로 생김
     */
    if (await checkIfPermissionGranted(context))
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => CameraScreen()));
    else {
      SnackBar snackBar = SnackBar(
        content: Text('사진, 파일, 마이크 접근을 허용해야 카메라 사용 가능합니다.!'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            _key.currentState.hideCurrentSnackBar();
            AppSettings.openAppSettings();
          },
        ),
      );
      _key.currentState.showSnackBar(snackBar);
    }
  }

  Future<bool> checkIfPermissionGranted(BuildContext context) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
      Permission.storage
    ].request();
    bool permitted = true;

    statuses.forEach((permission, permissionStatus) {
      if (!permissionStatus.isGranted) permitted = false;
    });
    return permitted;
  }
}
