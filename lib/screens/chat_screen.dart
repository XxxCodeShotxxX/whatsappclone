import 'dart:developer';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:whatsappclone/handlers/network_handler.dart';
import 'package:whatsappclone/models/message_model.dart';
import 'package:whatsappclone/models/user_model.dart';
import '../widgets/message_bubble.dart';
import '../widgets/show_modal_sheet.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {super.key, required this.friend, required this.currentUser});
  final User friend;
  final User currentUser;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool show = false;
  bool isTextEmpty = true;
  bool isOnline = false;
  late TextEditingController controller;
  FocusNode focusNode = FocusNode();
  late IO.Socket socket;
  ScrollController scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<MessageModel> messages = [];

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    scrollToBottom();
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });

    //messages = getMessagesByChatId(widget.friend.userId);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void connect() {
    socket = IO.io("http://192.168.1.69:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
      "query": {
        "senderId": widget.currentUser.userId,
        "receiverId": widget.friend.userId
      }
    });

    socket.connect();

    socket.on("receiveMessage", (data) {
      log('Received data: $data'); // Debug line to print incoming data
      if (mounted) {
        try {
          MessageModel message = MessageModel.fromJson(data);
          setState(() {
            messages.insert(0, message);
          });
        } catch (e) {
          log('Error deserializing data: $e'); // Debug line to print deserialization error
        }
      }
    });
    socket.on("receiveImageMessage", (data) {
      log('Received data: $data'); // Debug line to print incoming data
      if (mounted) {
        try {
          MessageModel message = MessageModel.fromJson(data);
          setState(() {
            messages.insert(0, message);
          });
        } catch (e) {
          log('Error deserializing data: $e'); // Debug line to print deserialization error
        }
      }
    });

  }



  void sendMessage() {
    if (controller.text.isNotEmpty) {
      socket.emit("sendMessage", {
        "message": controller.text,
        "senderId": widget.currentUser.userId,
        "receiverId": widget.friend.userId,
        "isImage": false,
        "path": null
      });

      setState(() {
        messages.insert(
            0,
            MessageModel(controller.text, widget.currentUser.userId,
                widget.friend.userId, false, null, null));
        controller.clear();
        isTextEmpty = true;
      });

      scrollToBottom();
    }
  }

  void sendImage(BuildContext context, XFile image, int pop) async {
    NetworkHandler networkHandler = NetworkHandler();
    try {
      var response = await networkHandler.postImage(
          "routes/addImage", image.path, image.name);
      if (response.statusCode == 200) {
        log("Image uploaded successfully");
      } else {
        log("Failed to upload image: ${response.statusCode}");
      }

      for (int i = 0; i < pop; i++) {
        Navigator.pop(context);
      }

      socket.emit("sendImageMessage", {
        "message": "Caption",
        "senderId": widget.currentUser.userId,
        "receiverId": widget.friend.userId,
        "isImage": true,
        "imagePath": image.path,
        "imageName": image.name
      });

      setState(() {
        messages.insert(
            0,
            MessageModel("Caption", widget.currentUser.userId,
                widget.friend.userId, true, image.path, image.name));
      });
    } catch (e) {
      log("Error: $e");
    }
  }

  void toggleEmoji() {
    focusNode.unfocus();
    focusNode.canRequestFocus = false;
    setState(() {
      show = !show;
    });
  }

  void onChangeTextField(String value) {
    setState(() {
      isTextEmpty = value.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(),
      body: buildBody(context),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 4,
      backgroundColor: Theme.of(context).colorScheme.primary,
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: Row(
          children: [
            IconButton(
              padding: const EdgeInsets.only(right: 0),
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: CircleAvatar(
                maxRadius: 20,
                backgroundColor: Colors.blueAccent,
                child: SvgPicture.asset("assets/icons/groups.svg"),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "name : ${widget.friend.userName}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Id : ${widget.friend.userId}",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color.fromARGB(255, 227, 221, 220),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: const [
        Icon(
          Icons.camera,
          color: Colors.white,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Icon(
            Icons.call,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 6),
          child: Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget buildBody(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Image.asset(
            "assets/images/chat_background.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          buildMessageList(),
          buildMessageBox(context),
        ],
      ),
    );
  }

  Widget buildMessageList() {
    return Positioned(
      top: 0,
      right: 0,
      left: 0,
      bottom: MediaQuery.of(context).size.height * 0.08,
      child: ListView.builder(
        reverse: true,
        controller: scrollController,
        shrinkWrap: true,
        itemCount: messages.length,
        itemBuilder: (BuildContext context, int index) {
          log(messages[index].imagePath.toString());
          return MessageBubble(
            isSenderByCurrentUser:
                messages[index].senderId == widget.currentUser.userId,
            messageContent: messages[index].messageContent,
            messageDate: DateTime.now(),
            messageStatus: 2,
            isImage: messages[index].isImage,
            imagePath: messages[index].imagePath,
            imageName: messages[index].imageName,
          );
        },
      ),
    );
  }

  Align buildMessageBox(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 55,
              child: Card(
                margin: const EdgeInsets.only(right: 2, left: 2, bottom: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextFormField(
                  focusNode: focusNode,
                  controller: controller,
                  onChanged: onChangeTextField,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  minLines: 1,
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      onPressed: toggleEmoji,
                      icon: const Icon(Icons.emoji_emotions),
                    ),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (builder) => ShowModalSheet(
                                  context: context, onSendImage: sendImage),
                            );
                          },
                          icon: const Icon(Icons.attach_file),
                        ),
                        const IconButton(
                          onPressed: null,
                          icon: Icon(Icons.camera_alt),
                        ),
                      ],
                    ),
                    border: InputBorder.none,
                    hintText: "Write a message ...",
                    contentPadding: const EdgeInsets.all(8),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 2),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                radius: 25,
                child: IconButton(
                  onPressed: () {
                    sendMessage();
                  },
                  icon: Icon(
                    isTextEmpty ? Icons.mic : Icons.send,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ]),
          if (show) emojiSelector(),
        ],
      ),
    );
  }

  Widget emojiSelector() {
    return EmojiPicker(
      onEmojiSelected: (category, emoji) {
        setState(() {
          controller.text += emoji.emoji;
        });
      },
    );
  }
}
