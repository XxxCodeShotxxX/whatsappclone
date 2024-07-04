import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_common/src/util/event_emitter.dart';
import 'package:whatsappclone/data/fake_chats.dart';
import 'package:whatsappclone/models/message_model.dart';
import 'package:whatsappclone/screens/login_screen.dart';

import '../widgets/message_bubble.dart';
import '../widgets/show_modal_sheet.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.targetId});
  final int targetId;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool show = false;
  bool isTextEmpty = true;
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  late IO.Socket socket;

  void toggleEmoji() {
    focusNode.unfocus();
    focusNode.canRequestFocus = false;

    setState(() {
      show = !show;
    });
  }


  void onChangeTextField(String value){
  
      setState(() {
        isTextEmpty = value.isEmpty;
      });
  }

  @override
  void initState() {
    super.initState();

      connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
  }

  void connect() {
    socket =  IO.io("http://192.168.1.69:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });

    socket.connect();
    socket.emit("signin",sourceChat.id);
    socket.on("receiveMessage",receiveMessage );

  }

void receiveMessage(dynamic data){
    MessageModel message = MessageModel(data["message"], DateTime.now(), 2, sourceChat.id == data["senderId"]);
    
    
    setState(() {
          messages.add(message);

    });
    
}
@override
  void dispose() {
    socket.dispose();
    super.dispose();
  }

  // void setMessage(){

  //     socket.on("getmessage", handler)
  //     MessageModel  message = MessageModel(
      
  //     );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    child: SvgPicture.asset("assets/icons/groups.svg")),
              ),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Amine Zebbiche",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 255, 255, 255))),
                    Text("Last seen recently",
                        style: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 227, 221, 220))),
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
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: PopScope(
          canPop: show ? false : true,
          onPopInvoked: (didPop) {
            if (show) {
              setState(() {
                show = false;
              });
            }
          },
          child: Stack(
            children: [
              Image.asset(
                "assets/images/chat_background.png",
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                bottom: MediaQuery.of(context).size.height * 0.08,
                child: ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return MessageBubble(
                      isSenderByCurrentUser:
                          messages[index].isSendedByCurrentUser,
                      messageContent:
                        messages[index].messageContent,
                      messageDate: messages[index].messageDate,
                      messageStatus: messages[index].messageStatus,
                    );
                  },
                ),
              ),
              messageBox(context)
            ],
          ),
        ),
      ),
    );
  }

  Align messageBox(BuildContext context) {
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
                    borderRadius: BorderRadius.circular(25)),
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
                                    backgroundColor:
                                        const Color.fromARGB(0, 255, 193, 7),
                                    context: context,
                                    builder: (builder) =>
                                        ShowModalSheet(context: context));
                              },
                              icon: const Icon(Icons.attach_file)),
                          const IconButton(
                              onPressed: null, icon: Icon(Icons.camera_alt))
                        ],
                      ),
                      border: InputBorder.none,
                      hintText: "Write a message ...",
                      contentPadding: const EdgeInsets.all(8)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 2),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                radius: 25,
                child:  IconButton(
                    onPressed: (){
                    if(!isTextEmpty)
                      
                      messages.add(MessageModel(controller.text, DateTime.now(), 2, true, ));
                    
                      socket.emit("message",{"message":controller
                      .text , "senderId" : sourceChat.id, "targetId" :widget.targetId});
                    controller.clear();
                    },
                    icon: Icon(
                      isTextEmpty ? Icons.mic : Icons.send,
                      color: Colors.white,
                    )),
              ),
            )
          ]),
          show ? emojiSelector() : Container(),
        ],
      ),
    );
  }

  Widget emojiSelector() {
    return EmojiPicker(
      onEmojiSelected: (category, emoji) {
        setState(() {
          controller.text = controller.text + emoji.emoji;
        });
      },
    );
  }
}

