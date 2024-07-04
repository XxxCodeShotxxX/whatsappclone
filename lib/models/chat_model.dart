import 'package:flutter/material.dart';

class ChatModel {
  int id;
  String name;
  Icon icon;
  bool isGroup;
  DateTime time;
  String lastMessage;
  String status;
  ChatModel(this.id, this.name, this.icon, this.isGroup, this.time,
      this.lastMessage, this.status);
}
