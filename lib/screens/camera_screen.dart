import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whatsapp_clone/widgets/image_view.dart';

import '../main.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;

  late Future<void> cameraValue;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.max);
    cameraValue = _cameraController.initialize();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            FutureBuilder(
                future: cameraValue,
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done)
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        child: CameraPreview(_cameraController));

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
            Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(top: 8.0),
                height: 100,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.flash_off,
                            size: 30,
                          ),
                          color: Colors.white,
                        ),
                        InkWell(
                          onTap: () {
                            snapShot(context);
                          },
                          child: Icon(
                            Icons.panorama_fish_eye,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.flip_camera_ios,
                            size: 30,
                          ),
                          color: Colors.white,
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Hold for video, tap for video",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void snapShot(context) async {
    try {
      final path =
          join((await getTemporaryDirectory()).path, "${DateTime.now()}.png");
      await _cameraController.takePicture(path);
      await Navigator.push(context,
          CupertinoPageRoute(builder: (_) => ImageViewer(imagePath: path)));
    } catch (e) {
      print(e);
    }
  }
}
