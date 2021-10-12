import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/model/chat_model.dart';
import 'package:whatsapp_clone/widgets/contact_card.dart';

import 'groups.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({Key? key}) : super(key: key);

  @override
  _SelectContactState createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  int _contactCount = 34;
  List _menuItems = [
    "Invite a friend",
    "Contacts",
    "Refresh",
    "Help",
  ];

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
                "Select Contact",
                style: TextStyle(fontSize: 19),
              ),
              Text(
                "$_contactCount contacts",
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
          ],
        ),
        body: ListView.builder(
            itemCount: chats.length + 2,
            itemBuilder: (builder, index) {
              if (index == 0)
                return InkWell(
                  onTap: () => Navigator.push(
                      context, CupertinoPageRoute(builder: (_) => NewGroup())),
                  child: ContactCard(
                    chat: ChatModel(
                        name: "New Group",
                        isGroup: true,
                        icon: Icons.groups,
                        status: ""),
                    color: theme.accentColor,
                  ),
                );
              else if (index == 1)
                return ContactCard(
                  chat: ChatModel(
                      name: "New Chat",
                      isGroup: false,
                      icon: Icons.person_add,
                      status: ""),
                  color: theme.accentColor,
                );
              var chat = chats[index - 2];
              return ContactCard(
                chat: chat,
                color: theme.indicatorColor,
              );
            }));
  }
}
