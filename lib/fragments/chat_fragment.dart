import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/model/chat_model.dart';
import 'package:whatsapp_clone/screens/select_contact.dart';
import 'package:whatsapp_clone/widgets/card.dart';

class ChatFragment extends StatefulWidget {
  const ChatFragment({Key? key}) : super(key: key);

  @override
  _ChatFragmentState createState() => _ChatFragmentState();
}

class _ChatFragmentState extends State<ChatFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (_) => SelectContact()));
        },
        backgroundColor: Theme.of(context).accentColor,
        child: Icon(Icons.message),
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          var chat = chats[index];
          return CardItem(chat: chat);
        },
      ),
    );
  }
}
