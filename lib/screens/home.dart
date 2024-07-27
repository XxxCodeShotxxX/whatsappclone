
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:whatsappclone/controllers/camera_controller.dart';
import 'package:whatsappclone/controllers/socket_controller.dart';
import 'package:whatsappclone/controllers/user_controller.dart';
import 'package:whatsappclone/keys/db_cnames.dart';
import 'package:whatsappclone/models/localdbmodel/db_chat_list_model.dart';
import 'package:whatsappclone/models/localdbmodel/db_message_model.dart';
import 'package:whatsappclone/screens/Tabs/camera_tab.dart';
import 'package:whatsappclone/screens/Tabs/chat_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  final SocketController socketController = Get.put(
    SocketController(),
    permanent: true,
  );
  final UserController userController = Get.put(UserController());
  final CameraGetController _cameraController = Get.put(CameraGetController());

  late TabController _tabController;
  double customTabBarHeight = 40;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    socketController.connect();
    _tabController = TabController(length: 4, initialIndex: 1, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      userController.updateUserStatus(true);
    } else {
      userController.updateUserStatus(false);
    }
  }

  void _handleTabChange() {
    if (!_tabController.indexIsChanging) {
      log('Current Tab Index: ${_tabController.index}');
      if (_tabController.index != 0) {
        _cameraController.turnOffFlash();
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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
            onPressed: () {
              Box<DbChatListModel> chatList =
                  Hive.box<DbChatListModel>(DbCnames.chatList);
              chatList.add(DbChatListModel(
                message: "test",
                messageId: "555555",
                messageType: "text",
                unreadCount: 3,
                createdAt: DateTime.now(),
                tickCount: 1,
                userId: "66954c513f58abf28e4e731f",
              ));
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          PopupMenuButton(
            onSelected: (value) {},
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: const Text("clear all chat boxes"),
                  onTap: () {
                    Box<DbChatListModel> chatList =
                        Hive.box<DbChatListModel>(DbCnames.chatList);
                    chatList.clear();
                  },
                ),
                PopupMenuItem(
                  child: const Text("clear all messages boxes"),
                  onTap: () {
                    Box<DbMessageModel> message =
                        Hive.box<DbMessageModel>(DbCnames.message);
                    message.clear();
                  },
                ),
                const PopupMenuItem(child: Text("Whatsapp Web")),
                const PopupMenuItem(child: Text("Starred Messages")),
                const PopupMenuItem(child: Text("Setting")),
              ];
            },
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(customTabBarHeight),
          child: LayoutBuilder(builder: (context, constraints) {
            final totalWidth = constraints.maxWidth / 2;
            final cameraTabWidth = totalWidth * 0.1; // 20% of the total width
            final otherTabWidth = (totalWidth - cameraTabWidth) / 3; // Remaining width divided by 3

            return TabBar(
              controller: _tabController,
              labelPadding: const EdgeInsets.symmetric(horizontal: 4),
              tabs: [
                Container(
                  height: customTabBarHeight,
                  width: cameraTabWidth,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.camera,
                    color: Colors.white,
                  ),
                ),
                Container(
                  height: customTabBarHeight,
                  width: otherTabWidth,
                  alignment: Alignment.center,
                  child: const Text(
                    "Chats",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  height: customTabBarHeight,
                  width: otherTabWidth,
                  alignment: Alignment.center,
                  child: const Text(
                    "Status",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  height: customTabBarHeight,
                  width: otherTabWidth,
                  alignment: Alignment.center,
                  child: const Text(
                    "Calls",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            );
          }),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
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
