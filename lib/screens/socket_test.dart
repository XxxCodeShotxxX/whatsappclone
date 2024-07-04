import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketTest extends StatefulWidget {
  const SocketTest({super.key});

  @override
  State<SocketTest> createState() => _SocketTestState();
}

class _SocketTestState extends State<SocketTest> {
  late IO.Socket socket;
  String error = "fine";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
  }

  void connect() {
    
    socket.onConnect((handler) => {error = "error"});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Text(
      error,
      style: TextStyle(color: Colors.red),
    )));
  }
}
