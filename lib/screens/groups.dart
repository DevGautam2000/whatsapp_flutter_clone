import 'dart:io' show Platform;
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/model/chat_model.dart';
import 'package:whatsapp_clone/widgets/card_for_group.dart';
import 'package:whatsapp_clone/widgets/contact_card.dart';

class NewGroup extends StatefulWidget {
  const NewGroup({Key? key}) : super(key: key);

  @override
  _NewGroupState createState() => _NewGroupState();
}

class _NewGroupState extends State<NewGroup> {
  List _menuItems = [
    "Invite a friend",
    "Contacts",
    "Refresh",
    "Help",
  ];

  List<ChatModel> groups = [];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          titleSpacing: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          brightness: Brightness.dark,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New Group",
                style: TextStyle(fontSize: 19),
              ),
              Text(
                "Add participants",
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  size: 26,
                )),
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
        ),
        body: Stack(children: [
          Padding(
            padding: groups.length > 0
                ? EdgeInsets.only(top: 90.0)
                : EdgeInsets.only(top: 0),
            child: ListView.builder(
                itemCount: chats.length,
                itemBuilder: (builder, index) {
                  var chat = chats[index];
                  var highlightColor = theme.accentColor.withOpacity(0.2);

                  return Material(
                    color: chat.selected ? highlightColor : Colors.transparent,
                    child: InkWell(
                      overlayColor: MaterialStateProperty.all(highlightColor),
                      onTap: () {
                        if (chat.selected == false && !chat.isGroup!) {
                          setState(() {
                            chat.selected = true;
                            groups.add(chat);
                          });
                        } else {
                          setState(() {
                            chat.selected = false;
                            groups.remove(chat);
                          });
                        }
                      },
                      child: ContactCard(
                        chat: chat,
                        color: theme.indicatorColor,
                      ),
                    ),
                  );
                }),
          ),
          groups.length > 0
              ? Column(
                  children: [
                    Container(
                      height: 75,
                      padding: EdgeInsets.all(5),
                      color: Colors.white,
                      child: ListView.builder(
                          itemCount: groups.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            var chat = groups[index];
                            return InkWell(
                                onTap: () {
                                  setState(() {
                                    chat.selected = false;
                                    groups.remove(chat);
                                  });
                                },
                                child: CardForGroup(chat: chat));
                          }),
                    ),
                    Divider(
                      thickness: 1,
                    )
                  ],
                )
              : Container(),
        ]));
  }
}
