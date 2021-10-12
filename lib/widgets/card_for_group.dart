import 'package:flutter/material.dart';
import 'package:whatsapp_clone/model/chat_model.dart';

class CardForGroup extends StatelessWidget {
  final ChatModel chat;

  const CardForGroup({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Container(
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).indicatorColor,
                  radius: 23,
                  child: Icon(
                    chat.icon,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.clear,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            chat.name,
            style: TextStyle(fontSize: 10),
          )
        ],
      ),
    );
  }
}
