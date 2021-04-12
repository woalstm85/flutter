import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_instagram/models/gallery_state.dart';
import 'package:flutter_instagram/screens/share_post_screen.dart';
import 'package:local_image_provider/device_image.dart';
import 'package:local_image_provider/local_image.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class MyGallery extends StatefulWidget {
  @override
  _MyGalleryState createState() => _MyGalleryState();
}

class _MyGalleryState extends State<MyGallery> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GalleryState>(
      builder: (BuildContext context, GalleryState galleryState, Widget child) {
        return GridView.count(
          /**
           * children: List.generate(
              30,
              (index) =>
              Image.network('https://picsum.photos/id/$index/150/150.jpg')),
           */
          crossAxisCount: 3,
          children: getImages(context, galleryState),
        );
      },
    );
  }

  List<Widget> getImages(BuildContext context, GalleryState galleryState) {
    return galleryState.images
        .map((localImage) => InkWell(
              onTap: () async {
                Uint8List bytes = await localImage.getScaledImageBytes(
                    galleryState.localImageProvider, 0.3);

                final String timeInMilli = DateTime.now()
                    .millisecondsSinceEpoch
                    .toString(); // timeInMilli : 파일명으로 쓰기위해
                try {
                  String path = join((await getTemporaryDirectory()).path,
                      '$timeInMilli.png'); // getTemporaryDirectory()).path : 폴더위치

                  File imageFile = File(path)..writeAsBytesSync(bytes);

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => SharePostScreen(imageFile)));
                } catch (e) {}
              },
              child: Image(
                image: DeviceImage(localImage, scale: 0.1),
                fit: BoxFit.cover,
              ),
            ))
        .toList();
  }

}
