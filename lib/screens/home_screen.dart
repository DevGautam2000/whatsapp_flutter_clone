import 'dart:io' show Platform;
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/fragments/camera_fragment.dart';
import 'package:whatsapp_clone/fragments/chat_fragment.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _controller;

  List _menuItems = [
    "New group",
    "New broadcast",
    "Linked devices",
    "Starred messages",
    "Payments",
    "Settings",
  ];

  @override
  void initState() {
    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WhatsApp"),
        brightness: Brightness.dark,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          Transform.rotate(
              angle: Platform.isAndroid ? math.pi : math.pi / 2,
              child: PopupMenuButton(
                  onSelected: (value) => print(value),
                  itemBuilder: (context) => _menuItems
                      .map((item) => buildPopupMenuItem(item))
                      .toList()))
        ],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          isScrollable: true,
          physics: NeverScrollableScrollPhysics(),
          labelPadding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .025),
          tabs: [
            Container(width: 25, child: Tab(icon: Icon(Icons.camera_alt))),
            buildTabContainer("CHATS"),
            buildTabContainer("STATUS"),
            buildTabContainer("CALLS"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          CameraFragment(),
          ChatFragment(),
          Text("this is status"),
          Text("this is calls"),
        ],
      ),
    );
  }

  Container buildTabContainer(itemName) {
    return Container(
      width: 100,
      child: Tab(
        text: itemName,
      ),
    );
  }

  PopupMenuItem<String> buildPopupMenuItem(itemName) {
    return PopupMenuItem(
      child: Text(itemName),
      value: itemName,
    );
  }
}
