import 'package:flutter/material.dart';
import 'package:flutter_instagram/widgets/take_photo.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  int _currentIndex = 1;
  PageController _pageController = PageController(initialPage: 1);
  String _title = "Photo";

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_title),
      ),
      body: PageView(
        controller: _pageController,
        // PageView :여러 페이지를 한 화면에서 처리할 수 있게 해주는 위젯
        children: <Widget>[
          Container(
            color: Colors.teal,
          ),
          TakePhoto(),
          Container(
            color: Colors.lightGreenAccent,
          ),
        ],
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
            switch(_currentIndex){
              case 0:
                _title = 'Gallery';
              break;
              case 1:
                _title = 'Photo';
                break;
              case 2:
                _title = 'Video';
                break;
            }
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 0,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.image_search_rounded), label: 'GALLERY'),
          BottomNavigationBarItem(
              icon: Icon(Icons.radio_button_checked), label: 'PHOTO'),
          BottomNavigationBarItem(
              icon: Icon(Icons.radio_button_checked), label: 'VIDEO'),
        ],
        currentIndex: _currentIndex,
        onTap: _onItemTabed,
      ),
    );
  }

  void _onItemTabed(index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(_currentIndex,
          duration: Duration(milliseconds: 200), curve: Curves.fastOutSlowIn);
    });
  }
}


