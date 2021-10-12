import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/screens/home_screen.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "OpenSans",
        primaryColor: Color(0xff075e54),
        accentColor: Color(0xff128c7e),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xff128c7e),
        ),
        primaryColorLight: Colors.green,
        indicatorColor: Colors.grey.shade400,
      ),
      home: HomeScreen(),
    );
  }
}
