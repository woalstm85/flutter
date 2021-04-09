import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import 'package:flutter_instagram/constants/common_size.dart';
import 'package:flutter_instagram/constants/screen_size.dart';
import 'package:flutter_instagram/models/camera_state.dart';
import 'package:flutter_instagram/screens/share_post_screen.dart';
import 'package:flutter_instagram/widgets/my_progress_indicator.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class TakePhoto extends StatefulWidget {
  const TakePhoto({
    Key key,
  }) : super(key: key);

  @override
  _TakePhotoState createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  Widget _progress = MyProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return Consumer<CameraState>(
      builder: (BuildContext context, CameraState cameraState, Widget child) {
        return Column(
          children: <Widget>[
            Container(
              width: size.width,
              height: size.width * 1.2,
              color: Colors.black,
              child: (cameraState.isReadyToTakePhoto)
                  ? _getPreview(cameraState)
                  : _progress,
            ),
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  if (cameraState.isReadyToTakePhoto) {
                    _attemptTakePhoto(cameraState, context);
                  }
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: Size.square(100.0),
                  shape: CircleBorder(),
                  side: BorderSide(color: Colors.black12, width: 20),
                ),
                child: Text(''),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _getPreview(CameraState cameraState) {
    return ClipRect(
      // ClipRect : Overflow된 부분을 잘라줌.
      child: OverflowBox(
        // OverflowBox : CameraPreview화면 밖으로 나갈수 있도록
        alignment: Alignment.center,
        // FittedBox : 차일드 또는 내욜물의 양에 따라 크키가 확장되는 위젯에 의해 Overflow가 발생되는 경우 디바이스 사이즈를 넘지않게 해줌.
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Container(
              height: size.height,
              child: CameraPreview(
                  cameraState.controller)), // CameraPreview : 카메라의 화면을 보여줌
        ),
      ),
    );
  }

  void _attemptTakePhoto(CameraState cameraState, BuildContext context) async {
    final String timeInMilli = DateTime.now().millisecondsSinceEpoch.toString(); // timeInMilli : 파일명으로 쓰기위해
    try {
      String path = join((await getTemporaryDirectory()).path, '$timeInMilli.png'); // getTemporaryDirectory()).path : 폴더위치
      XFile pcitureTaken = await cameraState.controller.takePicture();

      File imageFile = File(pcitureTaken.path);
      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SharePostScreen(imageFile)));
    } catch (e) {}
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
