import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:whatsappclone/handlers/network_handler.dart';
import 'package:whatsappclone/models/user_model.dart';
import 'package:whatsappclone/screens/Tabs/camera_tab.dart';
import 'package:whatsappclone/screens/Tabs/chat_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.currentUser, required this.users});
  final User currentUser;
    final List<User> users;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
    NetworkHandler  networkHandler =NetworkHandler();
    networkHandler.setOnline(widget.currentUser.userId.toString());
  }


  void connect() {
    socket = IO.io("http://192.168.1.69:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
      "query": {
        "senderId": widget.currentUser.userId,
      }
    });

    socket.connect();
    
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          "Whatsclone",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              )),
          PopupMenuButton(onSelected: (value) {
            if (kDebugMode) {
              print(value);
            }
          }, itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(child: Text("New Group")),
              const PopupMenuItem(child: Text("New broadcast")),
              const PopupMenuItem(child: Text("Whatsapp Web")),
              const PopupMenuItem(child: Text("Starred Messages")),
              const PopupMenuItem(child: Text("Setting")),
            ];
          })
        ],
        bottom:
            TabBar(labelColor: Colors.white, controller: _controller, tabs: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.camera,
              color: Colors.white,
            ),
          ),
          Text(
            "Chats",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "Status",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "Calls",
            style: TextStyle(color: Colors.white),
          )
        ]),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          const CameraTab(),
          ChatTab(currentUser: widget.currentUser, users: widget.users),
          const Text("status"),
          const Text("calls"),
        ],
      ),
    );
  }
}
