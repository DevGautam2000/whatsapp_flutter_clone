import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatModel {
  late String name;
  late IconData icon;
  late bool? isGroup;
  late String? time;
  late String? currentMessage;
  late String? status;
  bool selected = false;

  ChatModel(
      {required this.name,
      required this.icon,
      this.isGroup,
      this.time,
      this.currentMessage,
      this.status,
      this.selected = false});
}

List<ChatModel> chats = [
  ChatModel(
      name: "Gautam",
      icon: Icons.person,
      isGroup: false,
      time: "4:00 PM",
      currentMessage: "hi",
      status: "."),
  ChatModel(
      name: "Rishabh",
      icon: Icons.person,
      isGroup: false,
      time: "4:00 PM",
      currentMessage: "hi",
      status: "😄"),
  ChatModel(
      name: "Adittya",
      icon: Icons.person,
      isGroup: false,
      time: "4:00 PM",
      currentMessage: "hi",
      status: "hi there!"),
  ChatModel(
      name: "The Gyanis",
      icon: Icons.groups,
      isGroup: true,
      time: "4:00 PM",
      currentMessage: "hi",
      status: "local friends"),
];
