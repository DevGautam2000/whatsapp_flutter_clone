import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/model/chat_model.dart';
import 'package:whatsapp_clone/screens/chat_page.dart';

class CardItem extends StatelessWidget {
  final ChatModel chat;

  const CardItem({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (_) => ChatPage(
                      chatModel: this.chat,
                    ))),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.grey.shade200),
            ),
          ),
          child: ListTile(
            leading: GestureDetector(
              onTap: () {},
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: theme.indicatorColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  this.chat.icon,
                  color: Colors.white,
                ),
              ),
            ),
            title: Text(
              this.chat.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              children: [
                Icon(
                  Icons.done_all,
                  color: Colors.lightBlueAccent,
                  size: 20,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(this.chat.currentMessage!),
              ],
            ),
            trailing: Text(this.chat.time!),
          ),
        ),
      ),
    );
  }
}
