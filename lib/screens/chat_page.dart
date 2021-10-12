import 'dart:io' show Platform;
import 'dart:math' as math;

import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/model/chat_model.dart';

class ChatPage extends StatefulWidget {
  final ChatModel chatModel;

  const ChatPage({Key? key, required this.chatModel}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List _menuItems = [
    "View Contact",
    "Media,links, and docs",
    "Whatsapp web",
    "Search",
    "Mute Notifications",
    "Wallpaper",
  ];

  bool _show = false;
  FocusNode _focusNode = FocusNode();
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus && _show) {
        setState(() {
          _show = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        titleSpacing: 5,
        brightness: Brightness.dark,
        title: InkWell(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.chatModel.name),
              Text(
                "last seen today at ${widget.chatModel.time}",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),
          IconButton(onPressed: () {}, icon: Icon(Icons.call)),
          Transform.rotate(
            angle: Platform.isAndroid ? math.pi : math.pi / 2,
            child: PopupMenuButton(
                onSelected: (value) => print(value),
                itemBuilder: (context) => _menuItems
                    .map((item) => PopupMenuItem(
                          child: Text(item),
                          value: item,
                        ))
                    .toList()),
          )
        ],
        centerTitle: false,
        leadingWidth: 75,
        leading: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () => Navigator.pop(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(Icons.arrow_back),
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: theme.indicatorColor,
                child: Icon(
                  widget.chatModel.icon,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          child: WillPopScope(
            onWillPop: () {
              if (_show)
                setState(() {
                  _show = false;
                });
              else
                Navigator.pop(context);

              return Future.value(false);
            },
            child: Stack(
              children: [
                ListView(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: size.width * .83,
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    clipBehavior: Clip.hardEdge,
                                    child: TextFormField(
                                      style: TextStyle(fontSize: 18),
                                      controller: _textEditingController,
                                      focusNode: _focusNode,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      keyboardType: TextInputType.multiline,
                                      minLines: 1,
                                      maxLines: 5,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: "Type a message...",
                                          contentPadding: EdgeInsets.all(5),
                                          prefixIcon: IconButton(
                                            icon: Icon(
                                              Icons.emoji_emotions,
                                              color: Colors.grey,
                                            ),
                                            onPressed: () {
                                              _focusNode.unfocus();
                                              _focusNode.canRequestFocus =
                                                  false;
                                              setState(() {
                                                _show = !_show;
                                              });
                                            },
                                          ),
                                          suffixIcon: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Transform.rotate(
                                                angle: -math.pi / 6,
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.attach_file,
                                                    color: Colors.grey,
                                                  ),
                                                  onPressed: () {
                                                    showModalBottomSheet(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        context: context,
                                                        builder: (_) =>
                                                            bottomSheet(size));
                                                  },
                                                ),
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.camera_alt,
                                                  color: Colors.grey,
                                                ),
                                                onPressed: () {},
                                              )
                                            ],
                                          )),
                                    ))),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Theme.of(context).accentColor,
                              child: IconButton(
                                icon: Icon(
                                  Icons.mic,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                      ),
                      _show ? emojiSelect() : Container(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container bottomSheet(Size size) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 278,
      width: size.width * .9,
      child: Card(
        margin: EdgeInsets.all(18),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  getIcon(Icons.insert_drive_file, "Document", Colors.indigo),
                  getIcon(Icons.camera_alt, "Camera", Colors.pink),
                  getIcon(Icons.insert_photo, "Gallery", Colors.purple),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  getIcon(Icons.headset, "Audio", Colors.orange),
                  getIcon(Icons.location_pin, "Location", Colors.green),
                  getIcon(Icons.person, "Contact", Colors.blue),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getIcon(icon, text, color) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icon,
              size: 29,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(text),
          )
        ],
      ),
    );
  }

  Widget emojiSelect() {
    return EmojiPicker(
        selectedCategory: Category.SMILEYS,
        indicatorColor: Theme.of(context).accentColor,
        rows: 4,
        columns: 7,
        onEmojiSelected: (emoji, category) {
          setState(() {
            _textEditingController.text =
                _textEditingController.text + emoji.emoji;
          });
        });
  }
}
