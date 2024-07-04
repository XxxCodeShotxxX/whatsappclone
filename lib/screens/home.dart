import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:whatsappclone/screens/Tabs/camera_tab.dart';
import 'package:whatsappclone/screens/Tabs/chat_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Whatsapp Clone"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
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
            TabBar(
            
            labelColor: Colors.white, controller: _controller, tabs: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.camera)),
          const Text("Chats"),
          const Text("Status"),
          const Text("Calls")
        ]),
      ),
      body: TabBarView(
        controller: _controller,
        children: const [
          CameraTab(),
          ChatTab(),
          Text("status"),
          Text("calls"),
        ],
      ),
    );
  }
}
