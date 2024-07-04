import 'package:flutter/material.dart';
import 'package:whatsappclone/models/chat_model.dart';
import 'package:whatsappclone/models/message_model.dart';

List<ChatModel> chats = [
  ChatModel(1,
      "Amine Zebbiche",
      const Icon(Icons.gamepad_outlined),
      false,
      DateTime.now(),
      "Culpa cillum culpa aute velit labore aliqua laboris anim nisi veniam amet quis cupidatat.",
      "Aute commodo occaecat nisi do sint."),
  ChatModel(2,
      "Maria Zebbiche",
      const Icon(Icons.gamepad_outlined),
      false,
      DateTime.now(),
      "Culpa cillum culpa aute velit labore aliqua laboris anim nisi veniam amet quis cupidatat.",
      "Labore sunt est anim qui pariatur duis."),
  ChatModel(3,
      "Alex Smith",
      const Icon(Icons.gamepad_outlined),
      false,
      DateTime.now(),
      "Culpa cillum culpa aute velit labore aliqua laboris anim nisi veniam amet quis cupidatat.",
      "Pariatur in eu esse dolore pariatur eiusmod nulla."),
  ChatModel(4,
      "Walter White",
      const Icon(Icons.gamepad_outlined),false,
      DateTime.now(),
      "Culpa cillum culpa aute velit labore aliqua laboris anim nisi veniam amet quis cupidatat.",
      "Eiusmod sit proident anim nostrud voluptate et fugiat sunt tempor."),
];

List<MessageModel> messages = [
  // MessageModel("hey !!", DateTime(2024), 2, true),
  // MessageModel("how are you ?", DateTime(2024), 2, true),
  // MessageModel("im good", DateTime(2024), 2, false),
  // MessageModel("what about you?", DateTime(2024), 2, false),
  // MessageModel("everythting is OKEY", DateTime(2024), 2, true),
  // MessageModel(
  //     "Pariatur veniam aliquip commodo nulla occaecat ad reprehenderit ex culpa veniam.",
  //     DateTime(2024),
  //     2,
  //     false),
  // MessageModel(
  //     "Veniam nostrud cupidatat exercitation reprehenderit eu velit eiusmod esse enim veniam ullamco cillum.",
  //     DateTime(2024),
  //     1,
  //     true),
  // MessageModel(
  //     "Veniam nostrud cupidatat exercitation reprehenderit eu velit eiusmod esse enim veniam ullamco cillum.",
  //     DateTime(2024),
  //     1,
  //     true),
  // MessageModel(
  //     "Veniam nostrud cupidatat exercitation reprehenderit eu velit eiusmod esse enim veniam ullamco cillum.",
  //     DateTime(2024),
  //     1,
  //     true),
  // MessageModel("okay , goodbye", DateTime(2024), 0, true),
  // MessageModel("okay , goodbye", DateTime(2024), 0, false),
  // MessageModel("okay , goodbye", DateTime(2024), 0, true),
  // MessageModel("okay , goodbye", DateTime(2024), 0, false),
  // MessageModel("okay , goodbye", DateTime(2024), 0, true),
];
