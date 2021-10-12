import 'package:flutter/material.dart';
import 'package:whatsapp_clone/model/chat_model.dart';

class ContactCard extends StatelessWidget {
  ChatModel chat;
  Color color;

  ContactCard({
    Key? key,
    required this.chat,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var chat = this.chat;
    return ListTile(
      leading: Container(
        height: 50,
        width: 50,
        child: Stack(
          children: [
            CircleAvatar(
              backgroundColor: this.color,
              radius: 23,
              child: Icon(
                chat.icon,
                color: Colors.white,
              ),
            ),
            chat.selected
                ? Positioned(
                    bottom: 0,
                    right: 0,
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.teal,
                      size: 18,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
      title: Text(chat.name),
      subtitle: Text(chat.status!),
    );
  }
}
